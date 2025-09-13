import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String routename="home";
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo",style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        toolbarHeight:100,
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 356)),
            lastDate: DateTime.now().add(Duration(days: 356)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          )
        ],
      ),
    );
  }
}