import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:to_do_app/TaskItem.dart';
import 'package:to_do_app/Themeing/AppColors.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';

class Tasks extends StatefulWidget {
   Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
   DateTime dateTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: Appcolors.primarycolor,
              height: 50,
            ),
            CalendarTimeline(
              initialDate: dateTime,
              firstDate: DateTime.now().subtract(const Duration(days: 356)),
              lastDate: DateTime.now().add(const Duration(days: 356)),
              onDateSelected: (date){
                dateTime=date;
                setState(() {});
              },
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
            stream: FireBaseFunctions.gettask(dateTime),
            builder: (context, snapshot) {
              // 1- لسا بتحميل
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2- لو حصل ايرور
              if (snapshot.hasError) {
                return  Center(
                  child: Text("Something went wrong!",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),),
                );
              }

              // 3- لو مفيش داتا أو فاضية
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return  Center(
                  child: Text("No tasks available",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),),
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