import 'package:flutter/material.dart';
import 'package:to_do_app/Task_model.dart';
import 'package:to_do_app/Themeing/AppColors.dart';
import 'package:to_do_app/firebasefuntions.dart';

class Addtaskbottomsheet extends StatefulWidget {
  const Addtaskbottomsheet({super.key});

  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
}

class _AddtaskbottomsheetState extends State<Addtaskbottomsheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? selectedDate;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addTask() {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    TaskModel model = TaskModel(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      Date: DateUtils.dateOnly(selectedDate!).millisecondsSinceEpoch,
    );

    FireBaseFunctions.addtask(model).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add New Task", style: textStyle),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              style: textStyle, // يغير لون النص حسب الثيم
              decoration: InputDecoration(
                labelText: "Task Title",
                labelStyle: textStyle, // يغير لون الليبل حسب الثيم
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionController,
              maxLines: 2,
              style: textStyle,
              decoration: InputDecoration(
                labelText: "Task Description",
                labelStyle: textStyle,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              child: Row(
                children: [
                  const Icon(Icons.date_range, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    selectedDate == null
                        ? "Select Date"
                        : "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                    style: textStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Appcolors.primarycolor
              ),
              child:  Text("Add Task",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),),
            ),
          ],
        ),
      ),
    );
  }
}
