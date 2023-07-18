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
    var state = context.watch<MyAppState>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: ListTile(
          leading: Icon(
            Icons.circle_sharp,
            color: task.isDone ? Colors.green : Colors.amber,
          ),
          title: Text(task.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.createdTime.toString(),
                style: const TextStyle(fontSize: 10),
              ),
              if (task.isDone)
                const Text(
                  "Completed",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  state.deleteTask(task.id);
                },
                icon: const Icon(Icons.delete_outline_outlined),
              ),
              IconButton(
                onPressed: () {
                  state.markTaskAsDone(task.id);
                },
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 35,
                ),
              ),
            ],
          )),
    );
  }
}
