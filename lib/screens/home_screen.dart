import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  late Box taskBox;
  @override
  void initState() {
    super.initState();

    taskBox = Hive.box('tasks');

    loadTasks();
  }

  void loadTasks() {
    List stored = taskBox.get('task_list', defaultValue: []);

    tasks = stored.map((e) => Task.fromMap(e)).toList();
  }

  void saveTasks() {
    List data = tasks.map((e) => e.toMap()).toList();

    taskBox.put('task_list', data);
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
      saveTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);

      saveTasks();
    });
  }

  void toggleTask(int index, bool? value) {
    setState(() {
      tasks[index].completed = value!;

      saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedTasks = tasks.where((task) => task.completed).length;

    double progress = tasks.isEmpty ? 0 : completedTasks / tasks.length;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daily Reminder'),
            Text(
              'Total Tasks: ${tasks.length} | Completed: ${tasks.where((task) => task.completed).length}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),

      body: tasks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🎯 Start Your Success Journey',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Press + to add your first task',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '$completedTasks / ${tasks.length} Completed',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      LinearProgressIndicator(value: progress),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,

                    itemBuilder: (context, index) {
                      return TaskTile(
                        task: tasks[index],

                        onChanged: (value) {
                          toggleTask(index, value);
                        },

                        onDelete: () {
                          deleteTask(index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
        onPressed: () async {
          final result = await Navigator.push<Task>(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );

          if (result != null) {
            addTask(result);
          }
        },
      ),
    );
  }
}
