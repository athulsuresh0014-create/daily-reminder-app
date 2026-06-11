import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController controller = TextEditingController();
  int selectedDays = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            DropdownButton<int>(
              value: selectedDays,
              items: const [
                DropdownMenuItem(value: 30, child: Text("30 Days")),

                DropdownMenuItem(value: 60, child: Text("60 Days")),

                DropdownMenuItem(value: 90, child: Text("90 Days")),
              ],

              onChanged: (value) {
                setState(() {
                  selectedDays = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Task(
                      title: controller.text,
                      durationDays: selectedDays,
                      createdDate: DateTime.now(),
                    ),
                  );
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
