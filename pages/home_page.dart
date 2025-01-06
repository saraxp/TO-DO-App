// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:to_do_app/pages/tiles_page.dart';
import 'package:to_do_app/pages/add_button.dart';
import 'package:to_do_app/pages/task_data.dart';
import 'package:to_do_app/pages/completed_tasks.dart';
import 'package:to_do_app/pages/deleted_tasks.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskData> _tasks = [];
  List<TaskData> _completedTasks = [];
  List<TaskData> _deletedTasks = [];

  // Add a new task
  void _addWidgets() {
    setState(() {
      _tasks.add(TaskData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskText: '',
        isEditing: true,
        hideDeleteButton: true,
      ));
    });
  }

  // Hide delete buttons for all tasks
  void _hideDeleteButtonsForAllTasks() {
    setState(() {
      for (var task in _tasks) {
        task.hideDeleteButton = true; // Hide delete button
        task.isEditing = false; // Exit edit mode
      }
    });
  }

  // Update the text of a task
  void _updateTaskText(int index, String newText) {
    setState(() {
      _tasks[index].taskText = newText;
    });
  }

  // Mark task as completed
  void _markTaskAsCompleted(int index) {
    setState(() {
      // Mark the task as completed visually
      _tasks[index].isEditing = false;
      _tasks[index].hideDeleteButton = true;
    });

    // Delay the removal to ensure the UI updates before the task vanishes
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        final completedTask = _tasks[index];
        _tasks.removeAt(index);
        _completedTasks.add(completedTask);
      });
    });
  }

  // Toggle edit mode for a task
  void _toggleEditing(int index, bool isEditing) {
    setState(() {
      for (int i = 0; i < _tasks.length; i++) {
        _tasks[i].isEditing = false; // Ensure only one tile is in edit mode
      }
      _tasks[index].isEditing = isEditing;
    });
  }

  // Delete a task
  void _deleteTask(int index) {
    setState(() {
      final deletedTask = _tasks[index]; // Get the task directly
      _tasks.removeAt(index); // Remove it from the list
      _deletedTasks.add(deletedTask); // Add it to deleted tasks
    });
  }

  void _restoreTasksFromCompleted(List<TaskData> tasksToRestore) {
    setState(() {
      for (var task in tasksToRestore) {
        task.isChecked = false; // Unmark as completed
      }
      _tasks.addAll(tasksToRestore); // Add tasks back to the main list
      _completedTasks.removeWhere((task) => tasksToRestore.contains(task)); // Remove from completed tasks
    });
  }


  // Reload the app's content
  Future<void> _reloadContent() async {
    // Simulate a refresh operation (e.g., fetching updated tasks)
    await Future.delayed(Duration(seconds: 1)); // Simulate a network call

    // Here you can reset the task list or update it
    setState(() {
      _tasks = []; // For demonstration, clearing the task list
      _addWidgets(); // Add one default task to show reloading worked
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("TO DO APP"),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Spacer(),
            ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text('Completed Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksPage(
                      completedTasks: _completedTasks,
                      onRestoreTasks: _restoreTasksFromCompleted, // Pass the callback here
                    ),
                  ),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Deleted Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeletedTasksPage(
                      deletedTasks: _deletedTasks,
                      onRestoreTasks: (List<TaskData> tasksToRestore) {
                        setState(() {
                          for (var task in tasksToRestore) {
                            task.isChecked = false; // Ensure the task is not marked as completed
                            task.hideDeleteButton = true; //Ensure that delete button is hidden
                          }
                          _tasks.addAll(tasksToRestore); // Add restored tasks to the main list
                          _deletedTasks.removeWhere((task) => tasksToRestore.contains(task)); // Remove them from deleted tasks
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Account'),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _hideDeleteButtonsForAllTasks, // Hide delete buttons when tapping outside
        child: RefreshIndicator(
          onRefresh: _reloadContent, // Pull-to-refresh callback
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return Tiles(
                      taskText: _tasks[index].taskText,
                      isEditing: _tasks[index].isEditing,
                      hideDeleteButton: _tasks[index].hideDeleteButton,
                      onLongPress: () {
                        setState(() {
                          _tasks[index].hideDeleteButton = false; // Show delete button
                        });
                      },
                      onDelete: () => _deleteTask(index),
                      onTextChanged: (newText) => _updateTaskText(index, newText),
                      onToggleEditing: (isEditing) => _toggleEditing(index, isEditing),
                      onMarkAsCompleted: () => _markTaskAsCompleted(index), // Mark as completed
                      isChecked: _tasks[index].isChecked, // Pass isChecked state
                      onCheckedChanged: (bool value) {
                        setState(() {
                          _tasks[index].isChecked = value; // Update the checkbox state
                        });
                      },
                    );
                  },
                ),
              ),
              AddButton(onPressed: _addWidgets), // Use the AddButton widget here
            ],
          ),
        ),
      ),
    );
  }
}

