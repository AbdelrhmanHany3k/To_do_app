import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:to_do_app/TaskItem.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 50,
            ),
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 356)),
              lastDate: DateTime.now().add(Duration(days: 356)),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.blue,
              activeDayColor: Colors.blue,
              activeBackgroundDayColor: Colors.white,
              locale: 'en_ISO',
            )
          ],
        ),
        SizedBox(height: 24,),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return TaskItem();
          },itemCount: 50,),
        )
      ],
    );
  }
}
