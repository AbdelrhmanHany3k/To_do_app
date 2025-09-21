import 'package:flutter/material.dart';
import 'package:to_do_app/models/Task_model.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel task;
  static const String routename = "EditTask";

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.task.Date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Edit Task",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "This is title",
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Task details",
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now()
                          .subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (newDate != null) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select time",
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                        "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    widget.task.title = titleController.text;
                    widget.task.description = descriptionController.text;
                    widget.task.Date = DateUtils.dateOnly(selectedDate)
                        .millisecondsSinceEpoch;

                    try {
                      await FireBaseFunctions.updateTask(widget.task);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Changes saved locally, sync later"),
                        ),
                      );
                    }

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
