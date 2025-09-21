import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Themeing/AppColors.dart';
import 'package:to_do_app/login/Signin.dart';
import 'package:to_do_app/providers/Provider_auth.dart';
import 'package:to_do_app/tabs/AddTaskBottomSheet.dart';
import 'package:to_do_app/tabs/settings.dart';
import 'package:to_do_app/tabs/tasks.dart';

class Home extends StatefulWidget {
  static const String routename = "home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    Tasks(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ProviderAuth>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Hello ${provider.usermodel?.name ?? "User"}",
        ),
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, LoginScreen.routename);
          }, icon: Icon(Icons.logout_outlined),color: Appcolors.bottomdarkcolor,)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Addtaskbottomsheet(),
              );
            },
          );
        },
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // القطع حوالين الـ FAB
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          backgroundColor: Colors
              .transparent, // عشان الـ notch يبان وميبقاش فيه طبقة تغطيه
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },

          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
