import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text("Settings",
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mode",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18)),
              DropdownButton<String>(
                dropdownColor: Theme.of(context).cardColor, // لون الليستة حسب الثيم
                value: themeProvider.themeMode == ThemeMode.light
                    ? "Light"
                    : "Dark",
                style: Theme.of(context).textTheme.bodyLarge,
                items: [
                  DropdownMenuItem(
                    value: "Light",
                    child: Text(
                      "Light",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Dark",
                    child: Text(
                      "Dark",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    themeProvider.changeTheme(value);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}