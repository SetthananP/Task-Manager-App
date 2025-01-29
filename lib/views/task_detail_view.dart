import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import 'edit_task_view.dart';

class TaskDetailView extends StatelessWidget {
  final String taskId;

  const TaskDetailView({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final task = taskProvider.tasks.firstWhere((task) => task.id == taskId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Description:',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
            SizedBox(height: 16),
            Text(task.description, style: TextStyle(fontSize: 22)),
            SizedBox(height: 16),
            Text(
              'Due Date:',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              task.dueDate,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Status:',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Icon(Icons.circle,
                    color: taskProvider.getStatusColor(task.status), size: 16),
                const SizedBox(width: 8),
                Text(
                  task.status.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 22,
                      color: taskProvider.getStatusColor(task.status)),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskView(taskId: taskId),
                    ),
                  );
                },
                child: Text('Edit Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
