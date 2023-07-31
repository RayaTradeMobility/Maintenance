import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:maintenance/Views/loginScreen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key?key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: AnimatedSplashScreen(
          splash: Image.asset("assets/raya.png"), nextScreen: const LoginScreen(),
          duration: 3000,
          backgroundColor: Colors.white,
        ),
      ),

    );
  }
}
