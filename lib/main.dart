import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Edit%20task.dart';
import 'package:to_do_app/Task_model.dart';
import 'package:to_do_app/Themeing/MyTheme.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/nofication.dart';
import 'package:to_do_app/provider.dart';
import 'package:to_do_app/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init(); // ✅ تهيئة الإشعارات
  await FirebaseFirestore.instance.disableNetwork();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

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
      },
    );
  }
}