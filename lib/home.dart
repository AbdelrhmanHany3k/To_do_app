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
          Stack(
            children: [
              Container(
                color: Colors.blue,
                height: 60,
              ),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 356)),
                lastDate: DateTime.now().add(Duration(days: 356)),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.black,
                dayColor: Colors.black54,
                activeDayColor: Colors.blue,
                activeBackgroundDayColor: Colors.white,
                locale: 'en_ISO',
              )
            ],
          ),
        ],
      ),
    );
  }
}