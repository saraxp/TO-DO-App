import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/themes/theme_notifier.dart';
import 'package:to_do_app/pages/task_data.dart';

class DeletedTasksPage extends StatefulWidget {
  final List<TaskData> deletedTasks;
  final Function(List<TaskData>) onRestoreTasks; // Callback for restoring tasks

  const DeletedTasksPage({
    super.key,
    required this.deletedTasks,
    required this.onRestoreTasks,
  });

  @override
  State<DeletedTasksPage> createState() => _DeletedTasksPageState();
}

class _DeletedTasksPageState extends State<DeletedTasksPage> {
  final Set<int> _selectedTasks = {};
  bool _selectAll = false;
  bool _isSelectionMode = false;

  void _toggleTaskSelection(int index) {
    setState(() {
      if (_selectedTasks.contains(index)) {
        _selectedTasks.remove(index);
      } else {
        _selectedTasks.add(index);
      }

      if (_selectedTasks.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedTasks.addAll(List.generate(widget.deletedTasks.length, (i) => i));
      } else {
        _selectedTasks.clear();
      }

      if (_selectedTasks.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _deleteSelectedTasks() {
    setState(() {
      final List<int> indicesToDelete = _selectedTasks.toList()..sort((a, b) => b.compareTo(a));
      for (int index in indicesToDelete) {
        widget.deletedTasks.removeAt(index);
      }
      _selectedTasks.clear();
      _selectAll = false;
      _isSelectionMode = false;
    });
  }

  void _restoreSelectedTasks() {
    setState(() {
      List<TaskData> tasksToRestore = _selectedTasks.map((index) => widget.deletedTasks[index]).toList();
      widget.deletedTasks.removeWhere((task) => tasksToRestore.contains(task));
      _selectedTasks.clear();
      _selectAll = false;
      _isSelectionMode = false;
      widget.onRestoreTasks(tasksToRestore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomThemeExtension>()!;
    return Scaffold(
      backgroundColor: customTheme.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: customTheme.iconColor),
        title: null,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'Deleted Tasks',
              style: GoogleFonts.merriweather(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: customTheme.titleColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Divider(thickness: 1, color: customTheme.dividerColor),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isSelectionMode ? 50.0 : 0.0,
            child: _isSelectionMode
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: customTheme.checkboxColor,
                        checkColor: customTheme.checkColor,
                        value: _selectAll,
                        onChanged: (_) => _toggleSelectAll(),
                      ),
                      Text('Select All',
                        style: GoogleFonts.merriweather(
                          color: customTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _restoreSelectedTasks,
                        icon: Icon(Icons.restore, color: customTheme.iconColor),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: _deleteSelectedTasks,
                        icon: Icon(Icons.delete, color: customTheme.iconColor),
                      ),
                    ],
                  ),
                ],
              ),
            )
                : SizedBox.shrink(),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (_isSelectionMode) {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedTasks.clear();
                    _selectAll = false;
                  });
                }
              },
              child: ListView.builder(
                itemCount: widget.deletedTasks.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTasks.contains(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        if (_isSelectionMode)
                          AnimatedOpacity(
                            opacity: _isSelectionMode ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Checkbox(
                              activeColor: customTheme.checkboxColor,
                              checkColor: customTheme.checkColor,
                              value: isSelected,
                              onChanged: (_) => _toggleTaskSelection(index),
                            ),
                          ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_isSelectionMode) {
                                _toggleTaskSelection(index);
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                _isSelectionMode = true;
                                _toggleTaskSelection(index);
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isSelected ? customTheme.selectionColor: customTheme.tileColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: customTheme.borderColor!),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              child: Text(
                                widget.deletedTasks[index].taskText,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
