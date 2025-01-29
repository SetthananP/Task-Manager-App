import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class EditTaskView extends StatelessWidget {
  final String taskId;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  EditTaskView({super.key, required this.taskId});

  Color getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.pending:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final task = taskProvider.tasks.firstWhere((task) => task.id == taskId);

        titleController.text = task.title;
        descriptionController.text = task.description;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Task', style: TextStyle(fontSize: 30)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 20),
                const Text('Status:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                DropdownButton<TaskStatus>(
                  value: task.status,
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      taskProvider.updateTaskStatus(taskId, newStatus);
                    }
                  },
                  items: TaskStatus.values.map((status) {
                    return DropdownMenuItem<TaskStatus>(
                      value: status,
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              color: getStatusColor(status),
                              size: 14), // ไอคอนสีของ status
                          const SizedBox(width: 8),
                          Text(status.name.toUpperCase(),
                              style: TextStyle(color: getStatusColor(status))),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final updatedTask = Task(
                      id: taskId,
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: task.dueDate,
                      status: task.status,
                    );
                    taskProvider.updateTask(taskId, updatedTask);
                    Navigator.pop(context);
                  },
                  child: const Text('Edit Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
