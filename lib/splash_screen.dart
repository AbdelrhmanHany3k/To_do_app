import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/login/Signin.dart';
import 'package:to_do_app/providers/Provider_auth.dart';
import 'package:to_do_app/providers/provider_theme.dart';

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
      var authProvider = Provider.of<ProviderAuth>(context, listen: false);

      if (authProvider.firebaseuser != null) {
        Navigator.pushReplacementNamed(context, Home.routename);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routename);
      }
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
