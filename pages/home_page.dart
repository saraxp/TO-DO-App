// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:to_do_app/pages/tiles_page.dart';
import 'package:to_do_app/pages/add_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskData> _tasks = [];

  // Add a new task
  void _addWidgets() {
    setState(() {
      _tasks.add(TaskData(
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
      _tasks.removeAt(index);
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
                      onToggleEditing: (isEditing) =>
                          _toggleEditing(index, isEditing),
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

class TaskData {
  String taskText;
  bool isEditing;
  bool hideDeleteButton;

  TaskData({
    required this.taskText,
    required this.isEditing,
    required this.hideDeleteButton,
  });
}
