import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/newtaskmodal.dart';
import 'components/tasklistitem.dart';
import 'models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
        ),
        home: const MyHomePage(
          title: "Tasks",
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void createTask(String name, DateTime createdTime) {
    tasks.add(Task(
      name: name,
      createdTime: createdTime,
      completedTime: createdTime,
      isDone: false,
    ));
    print(tasks.length);
    notifyListeners();
  }

  void markTaskAsDone(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // -------- HEADER
          Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                children: [
                  Text('Today',
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.w300)),
                  Text(
                      'Here are your tasks for today. Remember to try your best and that\'s okay to fail sometimes. Tomorrow is a new day!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10)),
                ],
              )),
          // --------- BODY WITH TASK LIST
          Expanded(
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      task: state.tasks[index],
                    );
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            context: context,
            showDragHandle: true,
            builder: (context) =>
                const SizedBox(height: 200, child: NewTaskModal()),
          );
        },
        label: const Text('New Task'),
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          size: 20,
        ),
      ),
    );
  }
}
