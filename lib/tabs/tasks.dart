import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:to_do_app/TaskItem.dart';
import 'package:to_do_app/Task_model.dart';
import 'package:to_do_app/firebasefuntions.dart';

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
              firstDate: DateTime.now().subtract(const Duration(days: 356)),
              lastDate: DateTime.now().add(const Duration(days: 356)),
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
        const SizedBox(height: 24),
        Expanded(
          child: StreamBuilder(
            stream: FireBaseFunctions.gettask(),
            builder: (context, snapshot) {
              // 1- لسا بتحميل
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2- لو حصل ايرور
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              }

              // 3- لو مفيش داتا أو فاضية
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No tasks available"),
                );
              }

              // 4- لو في داتا
              var tasks = snapshot.data!.docs.map((doc) => doc.data()).toList();

              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(task: tasks[index]);
                },
                itemCount: tasks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}