import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/main.dart';

class NewTaskModal extends StatefulWidget {
  const NewTaskModal({super.key});

  @override
  State<NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<NewTaskModal> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    var taskNameController = TextEditingController();

    void createTask() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      ).then((value) => {
            if (value != null)
              {
                state.createTask(taskNameController.value.text, value),
                Navigator.pop(context)
              }
          });
    }

    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Task name',
              icon: Icon(Icons.add_task_outlined),
            ),
            controller: taskNameController,
          ),
          const SizedBox(height: 10),
          FilledButton(
            child: const Text('Create task'),
            onPressed: () {
              createTask();
            },
          ),
        ]));
  }
}
