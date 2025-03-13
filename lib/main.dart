import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart'; // You'll need to create this file with the Firebase CLI
import 'screens/home_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/trending_screen.dart';
import 'screens/about_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'ITEL App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(), // Start with splash screen
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const AppMockup(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AppMockup extends StatefulWidget {
  const AppMockup({super.key});

  @override
  State<AppMockup> createState() => _AppMockupState();
}

class _AppMockupState extends State<AppMockup> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const TrendingScreen(),
    const AboutScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Check authentication status
    final authProvider = Provider.of<AuthProvider>(context);
    
    // If not logged in and not loading, redirect to login
    if (!authProvider.isLoggedIn && !authProvider.isLoading) {
      // Use a post-frame callback to avoid build-during-build errors
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      
      // Return a loading indicator while transitioning
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            Container(
              height: 24,
              color: Colors.grey[900],
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9:41',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: _screens[_currentIndex],
            ),
            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue[600],
                unselectedItemColor: Colors.grey[500],
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'Courses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.trending_up),
                    label: 'Trending',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: 'About',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}