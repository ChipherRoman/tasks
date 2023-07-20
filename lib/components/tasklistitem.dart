import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/task.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.tertiary;
    final unselectedColor = Theme.of(context).colorScheme.primary;

    var state = context.watch<MyAppState>();

    String formatDate(DateTime date) {
      if (date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year) {
        return "Today";
      }
      return "${date.day}/${date.month}/${date.year}";
    }

    return ListTile(
        dense: task.isDone,
        enabled: task.isDone ? false : true,
        leading: Icon(
          task.isDone ? Icons.check_circle : Icons.circle_outlined,
          color: task.isDone ? selectedColor : unselectedColor,
        ),
        title: Text(task.name),
        subtitle: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDate(task.createdTime),
                style: const TextStyle(fontSize: 10),
              ),
              if (task.isDone)
                Text(
                  "Completed",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: selectedColor),
                ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                state.markTaskAsDone(task.id);
              },
              icon: Icon(
                task.isDone ? Icons.circle_rounded : Icons.circle_outlined,
                color: task.isDone ? selectedColor : unselectedColor,
                size: 35,
              ),
            ),
          ],
        ));
  }
}
