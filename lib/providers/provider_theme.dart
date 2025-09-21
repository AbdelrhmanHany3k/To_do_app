import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeProvider() {
    loadTheme(); // أول ما يشتغل يجيب آخر اختيار
  }

  void changeTheme(String mode) async {
    if (mode == "Light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", mode); // حفظ الاختيار
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedMode = prefs.getString("themeMode");

    if (savedMode != null) {
      if (savedMode == "Light") {
        themeMode = ThemeMode.light;
      } else {
        themeMode = ThemeMode.dark;
      }
      notifyListeners();
    }
  }
}
