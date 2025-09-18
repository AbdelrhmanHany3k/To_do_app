import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routename = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Home.routename);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    final isLight = themeProvider.themeMode == ThemeMode.light;

    return Scaffold(
      body: Center(
        child: Image.asset(
          isLight
              ? 'assets/images/splash@3x.png'
              : 'assets/images/splash_dark.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
