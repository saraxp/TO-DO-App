// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _title = '';
  final TextEditingController _titleController =
  TextEditingController(); // Controller for the title input
  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>(); // Key for controlling the Scaffold


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
      _tasks[index].isEditing = false;
      _tasks[index].hideDeleteButton = true;
    });

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
      final deletedTask = _tasks[index];
      _tasks.removeAt(index);
      _deletedTasks.add(deletedTask);
    });
  }

  void _restoreTasksFromCompleted(List<TaskData> tasksToRestore) {
    setState(() {
      for (var task in tasksToRestore) {
        task.isChecked = false; // Unmark as completed
      }
      _tasks.addAll(tasksToRestore);
      _completedTasks.removeWhere((task) => tasksToRestore.contains(task));
    });
  }

  // Reload the app's content
  Future<void> _reloadContent() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _tasks.clear();
      _title = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      backgroundColor: Color(0xFFDDF2FD),
      endDrawer: Drawer(
        backgroundColor: Color(0xFF000033),
        child: Padding(
          padding: const EdgeInsets.only(top: 520.0),
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  'lib/icons/list2.svg',
                  colorFilter: ColorFilter.mode(Color(0xFFFBFAF5), BlendMode.srcIn),
                ),
                title: Text(
                  'Completed Tasks',
                  style: TextStyle(color: Color(0xFFFBFAF5)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompletedTasksPage(
                        completedTasks: _completedTasks,
                        onRestoreTasks: _restoreTasksFromCompleted,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                  'lib/icons/delete2.svg',
                  colorFilter: ColorFilter.mode(Color(0xFFFBFAF5), BlendMode.srcIn),
                  ),
                  title: Text(
                    'Deleted Tasks',
                    style: TextStyle(color: Color(0xFFFBFAF5)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeletedTasksPage(
                          deletedTasks: _deletedTasks,
                          onRestoreTasks: (List<TaskData> tasksToRestore) {
                            setState(() {
                              for (var task in tasksToRestore) {
                                task.isChecked = false;
                                task.hideDeleteButton = true;
                              }
                              _tasks.addAll(tasksToRestore);
                              _deletedTasks.removeWhere(
                                      (task) => tasksToRestore.contains(task));
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                      'lib/icons/theme.svg',
                          colorFilter: ColorFilter.mode(Color(0xFFFBFAF5), BlendMode.srcIn),
                  ),
                  title: Text(
                    'Themes',
                    style: TextStyle(color: Color(0xFFFBFAF5)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                child: Divider(thickness: 1, color: Color(0xFFFBFAF5),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'lib/icons/settings.svg',
                    colorFilter: ColorFilter.mode(Color(0xFFFBFAF5), BlendMode.srcIn),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Color(0xFFFBFAF5)),
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'lib/icons/account.svg',
                  colorFilter: ColorFilter.mode(Color(0xFFFBFAF5), BlendMode.srcIn),
                ),
                title: Text(
                  'Account',
                  style: TextStyle(color: Color(0xFFFBFAF5)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _hideDeleteButtonsForAllTasks,
        child: RefreshIndicator(
          onRefresh: _reloadContent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        // Menu Button at the Top
        Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 5.0),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF000033)),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ),
      ),
      // Title Section
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: GoogleFonts.merriweather(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000033),
                ),
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.merriweather(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF5C5C7A),
                  ),
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              Divider(thickness: 2, color: Color(0xFF000033)),
            ],
          ),
        ),
              // Task List
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
                          _tasks[index].hideDeleteButton = false;
                        });
                      },
                      onDelete: () => _deleteTask(index),
                      onTextChanged: (newText) => _updateTaskText(index, newText),
                      onToggleEditing: (isEditing) => _toggleEditing(index, isEditing),
                      onMarkAsCompleted: () => _markTaskAsCompleted(index),
                      isChecked: _tasks[index].isChecked,
                      onCheckedChanged: (bool value) {
                        setState(() {
                          _tasks[index].isChecked = value;
                        });
                      },
                    );
                  },
                ),
              ),
              AddButton(
                  onPressed: _addWidgets,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
