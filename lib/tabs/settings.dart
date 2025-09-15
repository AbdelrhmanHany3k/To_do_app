import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedLanguage = "English";
  String selectedMode = "Light";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDFECDB),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("Settings",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
          SizedBox(height: 30),

          // Language
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Language",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedLanguage,
                items: [
                  DropdownMenuItem(value: "English", child: Text("English")),
                  DropdownMenuItem(value: "Arabic", child: Text("Arabic")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 30),

          // Mode
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mode",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedMode,
                items: [
                  DropdownMenuItem(value: "Light", child: Text("Light")),
                  DropdownMenuItem(value: "Dark", child: Text("Dark")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedMode = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
