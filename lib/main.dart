import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zonne/screens/onboarding_screen.dart';
import 'package:zonne/screens/profile_page.dart';
import 'firebase_options.dart';
import 'screens/googleMap_screen.dart';
import 'screens/swiper_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zonne App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> _checkUserLoggedIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // User is logged in, check if user document exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('kullanicilar')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        return true; // User document exists
      }
    }
    return false; // User is not logged in or user document does not exist
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            return const MainScreen();
          } else {
            return OnboardingScreen();
          }
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const SwiperScreen(),
    // Diğer sayfaları buraya ekleyin, örneğin:
    Container(color: Colors.red), // Favoriler Sayfası
    Container(color: Colors.green), // Mesajlar Sayfası
    const ProfilePage(),
    const MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  "assets/images/gradient.png",
                  width: 30,
                  height: 40,
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
                color: _selectedIndex == 0 ? Colors.pink : Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  _onItemTapped(1);
                },
                color: _selectedIndex == 1 ? Colors.pink : Colors.grey,
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(FontAwesomeIcons.message),
                onPressed: () {
                  _onItemTapped(2);
                },
                color: _selectedIndex == 2 ? Colors.pink : Colors.grey,
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  _onItemTapped(3);
                },
                color: _selectedIndex == 3 ? Colors.pink : Colors.grey,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: () {
          setState(() {
            _selectedIndex = 4;
          });
        },
        backgroundColor: Colors.pink,
        child: Image.asset(
          "assets/images/map.png",
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}
