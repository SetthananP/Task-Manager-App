import 'package:flutter/material.dart';
import 'add_task_view.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';
import 'task_detail_view.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task List',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              task.dueDate.toString(),
              style: TextStyle(fontSize: 18),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle,
                    color: taskProvider.getStatusColor(task.status), size: 14),
                const SizedBox(width: 8),
                Text(
                  task.status.name.toUpperCase(),
                  style: TextStyle(
                      color: taskProvider.getStatusColor(task.status)),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailView(
                    taskId: task.id,
                  ),
                ),
              );
            },
            onLongPress: () {
              taskProvider.deleteTask(task.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskView(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
