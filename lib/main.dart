import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/login/Signin.dart';
import 'package:to_do_app/login/signup.dart';
import 'package:to_do_app/providers/Provider_auth.dart';
import 'package:to_do_app/tabs/Edit%20task.dart';
import 'package:to_do_app/models/Task_model.dart';
import 'package:to_do_app/Themeing/MyTheme.dart';
import 'package:to_do_app/firebase/firebase_options.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/nofication.dart';
import 'package:to_do_app/providers/provider_theme.dart';
import 'package:to_do_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => ProviderAuth()), // هنا ضفنا Auth
    ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var authprovider=Provider.of<ProviderAuth>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routename,
      themeMode: provider.themeMode,
      theme: Mytheme.lighttheme,
      darkTheme: Mytheme.darktheme,
      routes: {
        Home.routename: (context) => Home(),
        SplashScreen.routename: (context) => const SplashScreen(),
        EditTaskScreen.routename: (context) => EditTaskScreen(
          task: ModalRoute.of(context)!.settings.arguments as TaskModel,
        ),
        LoginScreen.routename:(context)=>LoginScreen(),
        Signupscreen.routename:(context)=>Signupscreen(),
      },
    );
  }
}