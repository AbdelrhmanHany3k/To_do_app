import 'package:flutter/material.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.routename,
      routes: {
        Home.routename: (context) => const Home(),
        SplashScreen.routename: (context) => const SplashScreen(),
      },
    );
  }
}
