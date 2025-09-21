import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/tabs/Edit%20task.dart';
import 'package:to_do_app/models/Task_model.dart';
import 'package:to_do_app/firebase/firebasefuntions.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  void _markAsDone(BuildContext context) async {
    task.isdone = true;
    await FireBaseFunctions.updateTask(task);
  }

  void _deleteTask(BuildContext context) async {
    await FireBaseFunctions.deleteTask(task.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Slidable(
        key: ValueKey(task.id),
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => _deleteTask(context),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              flex: 3,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  EditTaskScreen.routename,
                  arguments: task,
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              flex: 2,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor, // خلفية حسب الثيم
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  task.isdone ? Icons.check_circle : Icons.circle_outlined,
                  color: task.isdone ? Colors.green : theme.hintColor,
                ),
                onPressed: () => _markAsDone(context),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        decoration: task.isdone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor, // لون يتغير حسب الثيم
                        decoration: task.isdone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${DateTime.fromMillisecondsSinceEpoch(task.Date).day}/"
                    "${DateTime.fromMillisecondsSinceEpoch(task.Date).month}/"
                    "${DateTime.fromMillisecondsSinceEpoch(task.Date).year}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
