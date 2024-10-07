// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:to_do_app/pages/add_button.dart';
import 'package:to_do_app/pages/tiles_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskData> _tasks = [];

  void _addWidgets() {
    setState(() {
      _tasks.add(TaskData(
          hideDeleteButton: true)); // Add a new task with delete button hidden
    });
  }

  void _hideDeleteButtonsForAllTasks() {
    setState(() {
      for (var task in _tasks) {
        task.hideDeleteButton = true; // Hide delete button for each task
      }
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
        onTap: () {
          setState(() {
            _hideDeleteButtonsForAllTasks();
          });
        },
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Tiles(
                      hideDeleteButton: _tasks[index].hideDeleteButton,
                      onLongPress: () {
                        setState(() {
                          _tasks[index].hideDeleteButton =
                              false; // Show delete button on long press
                        });
                      });
                }),
          ),
          AddButton(onPressed: () => _addWidgets()),
        ]),
      ),
    );
  }
}

class TaskData {
  bool hideDeleteButton;
  TaskData({required this.hideDeleteButton});
}
