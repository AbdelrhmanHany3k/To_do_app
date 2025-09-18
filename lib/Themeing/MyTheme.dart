import 'package:flutter/material.dart';
import 'package:to_do_app/Themeing/AppColors.dart';

class Mytheme {
  static final ThemeData lighttheme = ThemeData(
    primaryColor: Appcolors.primarycolor,
    scaffoldBackgroundColor: Appcolors.backgroundlightcolor,
    cardColor: Appcolors.whitecolor, // خلفية الكاردز في اللايت
    hintColor: Colors.grey, // لون النصوص الثانوية في اللايت
    appBarTheme: const AppBarTheme(
      backgroundColor: Appcolors.primarycolor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Appcolors.whitecolor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Colors.black54,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Appcolors.primarycolor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 28),
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Appcolors.whitecolor,
    ),
  );

  static final ThemeData darktheme = ThemeData(
    primaryColor: Appcolors.primarycolor,
    scaffoldBackgroundColor: Appcolors.backgrounddarkcolor,
    cardColor: Appcolors.bottomdarkcolor, // خلفية الكاردز في الدارك
    hintColor: Colors.grey[400], // لون النصوص الثانوية في الدارك
    appBarTheme: const AppBarTheme(
      backgroundColor: Appcolors.primarycolor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Appcolors.blackcolor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Appcolors.backgrounddarkcolor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Appcolors.whitecolor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Colors.white60,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Appcolors.primarycolor,
      unselectedItemColor: Appcolors.whitecolor,
      selectedIconTheme: IconThemeData(size: 28),
      showUnselectedLabels: false,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Appcolors.bottomdarkcolor,
    ),
  );
}
