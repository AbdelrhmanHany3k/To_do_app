import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String routename="home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
    );
  }
}