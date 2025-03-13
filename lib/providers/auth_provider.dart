import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../models/user.dart' as app_user;

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _firebaseUser;
  app_user.User? _appUser;
  bool _isAdmin = false;
  bool _isLoading = false;
  String _error = '';

  // Getters
  User? get firebaseUser => _firebaseUser;
  app_user.User? get appUser => _appUser;
  bool get isLoggedIn => _firebaseUser != null;
  bool get isAdmin => _isAdmin;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Constructor
  AuthProvider() {
    _initAuth();
  }

  // Initialize authentication state
  Future<void> _initAuth() async {
    _setLoading(true);
    
    // Listen to auth state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _firebaseUser = user;
      
      if (user != null) {
        // Try to load from local storage first for faster UI rendering
        app_user.User? localUser = await _authService.loadUserLocally();
        if (localUser != null) {
          _appUser = localUser;
          app_user.User.currentUser = localUser;
          notifyListeners();
        }
        
        // Check admin status
        _isAdmin = await _authService.isUserAdmin();
      } else {
        _appUser = null;
        _isAdmin = false;
        // Reset to default user
        app_user.User.currentUser = app_user.User(
          id: '0',
          name: 'Guest User',
          email: 'guest@example.com',
          phone: '',
          tier: app_user.MembershipTier.standard,
          membershipExpiryDate: '',
        );
      }
      
      _setLoading(false);
      notifyListeners();
    });
  }

  // Sign in
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _error = '';
    
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isAdmin = await _authService.isUserAdmin();
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register(String email, String password, String name, String phone, {String? company}) async {
    _setLoading(true);
    _error = '';
    
    try {
      await _authService.registerWithEmailAndPassword(
        email, password, name, phone, company: company);
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
    } catch (e) {
      _error = _handleAuthError(e);
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Update user membership tier
  Future<void> updateUserTier(String userId, app_user.MembershipTier tier) async {
    _setLoading(true);
    try {
      await _authService.updateUserTier(userId, tier);
      if (userId == _appUser?.id) {
        _appUser = _appUser?.copyWith(tier: tier);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Update favorites
  Future<void> updateFavorites(List<String> favoriteIds) async {
    if (_firebaseUser == null) return;
    
    try {
      await _authService.updateUserFavorites(favoriteIds);
      if (_appUser != null) {
        _appUser = _appUser!.copyWith(favoriteCoursesIds: favoriteIds);
        app_user.User.currentUser = app_user.User.currentUser.copyWith(
          favoriteCoursesIds: favoriteIds,
        );
      }
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  // Admin: Get all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    if (!_isAdmin) {
      _error = 'Unauthorized: Only admins can access user list';
      notifyListeners();
      return [];
    }
    
    try {
      return await _authService.getAllUsers();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Admin: Make user admin
  Future<void> makeUserAdmin(String userId) async {
    if (!_isAdmin) {
      _error = 'Unauthorized: Only admins can promote other users';
      notifyListeners();
      return;
    }
    
    _setLoading(true);
    try {
      await _authService.makeUserAdmin(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  String _handleAuthError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'Email is already in use.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Email address is invalid.';
        default:
          return 'Authentication error: ${e.message}';
      }
    }
    return e.toString();
  }
}