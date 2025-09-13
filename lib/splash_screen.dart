import 'dart:async';
import 'package:flutter/material.dart';
import 'package:to_do_app/home.dart';

class SplashScreen extends StatefulWidget {
  static const String routename="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/splash@3x.png'), // put your splash image
        ),
      ),
    );
  }
}