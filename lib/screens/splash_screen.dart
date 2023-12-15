import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/screens/beranda_screen.dart';
import 'package:wisata_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> checkIsLogin(BuildContext context) async {
  // await SessionManager().isLogin(context);
  final accessToken = await SessionManager.getToken();
  print('woi');
  print(accessToken);
  if (accessToken != null) {
    // to beranda screesn
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BerandaScreen()),
      (route) => false,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // checkIsLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo-jabar.png',
            width: 300,
          ),
          const Text(
            'Jabar Explorer',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      splashIconSize: 400,
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
      backgroundColor: Colors.black,
      nextScreen: const HomeScreen(),
    );
  }
}
