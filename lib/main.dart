import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/components/daytaskfilter.dart';
import 'package:tasks/strings/strings.dart';

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
      child: Consumer<MyAppState>(
        builder: (context, state, child) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: state._appColor,
            ),
            home: const MyHomePage(
              title: "Tasks",
            ),
          );
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // App Color section
  var _appColor = ColorScheme.fromSeed(seedColor: Colors.limeAccent);

  void setAppColor(Color color, {bool isDark = false}) {
    _appColor = ColorScheme.fromSeed(
        seedColor: color,
        brightness: isDark ? Brightness.dark : Brightness.light);
    notifyListeners();
  }

  // Task section
  final List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  void createTask(String name, DateTime createdTime) {
    tasks.add(Task(
      name: name,
      createdTime: createdTime,
      completedTime: createdTime,
      isDone: false,
    ));
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

  // Day filter section
  var _dayFilter = DateTime.now().weekday;
  int get dayFilter => _dayFilter;

  List<Task> get filteredTasks => _tasks
      .where((task) => task.createdTime.weekday == _dayFilter)
      .toList() // sort by is done
    ..sort((a, b) => a.isDone ? 1 : -1);

  void setDayFilter(int day) {
    _dayFilter = day;
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
        title: Text(widget.title),
      ),
      // watch oppenheimer
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          SystemStrings.getWeekday(state._dayFilter),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            state.setAppColor(Colors.purple);
                          },
                          icon: const Icon(
                            Icons.circle,
                            color: Colors.purple,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            state.setAppColor(Colors.amberAccent, isDark: true);
                          },
                          highlightColor: Colors.amberAccent,
                          icon: const Icon(
                            Icons.circle,
                            color: Colors.amberAccent,
                            size: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const DayTasksFilter(),
                const SizedBox(height: 8),
                const Text(
                  SystemStrings.taskViewBottomText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: ListView.builder(
                  itemCount: state.filteredTasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(state.filteredTasks[index].id),
                      onDismissed: (direction) {
                        state.deleteTask(state.filteredTasks[index].id);
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskListItem(
                        task: state.filteredTasks[index],
                      ),
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
