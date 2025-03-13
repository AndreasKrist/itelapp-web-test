import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as app_user;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      
      // Fetch user data
      await _getUserData(result.user!.uid);
      
      return result;
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password, String name, String phone, {String? company}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      // Create user profile in Firestore
      await _createUserProfile(
        result.user!.uid,
        email,
        name,
        phone,
        company: company,
      );
      return result;
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  // Create user profile in Firestore
  Future<void> _createUserProfile(
      String uid, String email, String name, String phone, {String? company}) async {
    await _firestore.collection('users').doc(uid).set({
      'id': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'company': company,
      'tier': 'standard', // Default tier
      'isAdmin': false, // Default role
      'membershipExpiryDate': DateTime.now().add(Duration(days: 365)).toIso8601String(),
      'favoriteCoursesIds': [],
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    // Save current user data locally
    await _saveUserLocally(uid, name, email, phone, company, 
      app_user.MembershipTier.standard.toString(), false);
  }

  // Get user data from Firestore
  Future<app_user.User> _getUserData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      
      // Convert membershipTier from string to enum
      app_user.MembershipTier tier = data['tier'] == 'pro' 
          ? app_user.MembershipTier.pro 
          : app_user.MembershipTier.standard;
      
      // Convert favoriteCoursesIds from List<dynamic> to List<String>
      List<String> favorites = (data['favoriteCoursesIds'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ?? [];
      
      // Create app user object
      app_user.User appUser = app_user.User(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        phone: data['phone'],
        company: data['company'],
        tier: tier,
        membershipExpiryDate: data['membershipExpiryDate'],
        favoriteCoursesIds: favorites,
      );
      
      // Save current user data locally
      await _saveUserLocally(
        appUser.id, 
        appUser.name, 
        appUser.email, 
        appUser.phone, 
        appUser.company, 
        appUser.tier.toString(),
        data['isAdmin'] ?? false,
      );
      
      // Update the static current user in the model
      app_user.User.currentUser = appUser;
      
      return appUser;
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

  // Save user data to local storage for offline access
  Future<void> _saveUserLocally(
      String id, String name, String email, String phone, String? company, 
      String tier, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', id);
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_phone', phone);
    await prefs.setString('user_company', company ?? '');
    await prefs.setString('user_tier', tier);
    await prefs.setBool('user_is_admin', isAdmin);
  }

  // Load user data from local storage
  Future<app_user.User?> loadUserLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('user_id');
    
    if (id == null) return null;
    
    String name = prefs.getString('user_name') ?? '';
    String email = prefs.getString('user_email') ?? '';
    String phone = prefs.getString('user_phone') ?? '';
    String? company = prefs.getString('user_company');
    String tierStr = prefs.getString('user_tier') ?? '';
    String expiryDate = prefs.getString('user_membership_expiry_date') ?? 
        DateTime.now().add(Duration(days: 365)).toIso8601String();
    
    app_user.MembershipTier tier = tierStr.contains('pro') 
        ? app_user.MembershipTier.pro 
        : app_user.MembershipTier.standard;
    
    app_user.User user = app_user.User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      company: company,
      tier: tier,
      membershipExpiryDate: expiryDate,
      favoriteCoursesIds: [],
    );
    
    app_user.User.currentUser = user;
    return user;
  }

  // Check if user is admin
  Future<bool> isUserAdmin() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return false;
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('user_is_admin') ?? false;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await _auth.signOut();
      
      // Reset current user to default
      app_user.User.currentUser = app_user.User(
        id: '0',
        name: 'Guest User',
        email: 'guest@example.com',
        phone: '',
        tier: app_user.MembershipTier.standard,
        membershipExpiryDate: '',
      );
    } catch (e) {
      print('Sign out error: $e');
      rethrow;
    }
  }

  // Update user membership tier
  Future<void> updateUserTier(String userId, app_user.MembershipTier tier) async {
    try {
      // Update in Firestore
      await _firestore.collection('users').doc(userId).update({
        'tier': tier == app_user.MembershipTier.pro ? 'pro' : 'standard',
        'membershipExpiryDate': DateTime.now().add(Duration(days: 365)).toIso8601String(),
      });
      
      // Update local user data
      if (userId == app_user.User.currentUser.id) {
        app_user.User.currentUser = app_user.User.currentUser.copyWith(
          tier: tier,
          membershipExpiryDate: DateTime.now().add(Duration(days: 365)).toIso8601String(),
        );
        
        // Update SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_tier', tier.toString());
        await prefs.setString('user_membership_expiry_date', 
            DateTime.now().add(Duration(days: 365)).toIso8601String());
      }
    } catch (e) {
      print('Error updating user tier: $e');
      rethrow;
    }
  }

  // Update user favorites
  Future<void> updateUserFavorites(List<String> favoriteIds) async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return;
    
    try {
      await _firestore.collection('users').doc(firebaseUser.uid).update({
        'favoriteCoursesIds': favoriteIds,
      });
    } catch (e) {
      print('Error updating favorites: $e');
      rethrow;
    }
  }
  
  // Make user an admin (only to be called by another admin)
  Future<void> makeUserAdmin(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isAdmin': true,
      });
    } catch (e) {
      print('Error making user admin: $e');
      rethrow;
    }
  }
  
  // Get all users (admin only)
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      if (!(await isUserAdmin())) {
        throw Exception('Unauthorized: Only admins can access user list');
      }
      
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting all users: $e');
      rethrow;
    }
  }
}