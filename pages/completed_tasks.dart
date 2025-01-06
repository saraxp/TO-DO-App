import 'package:flutter/material.dart';
import 'package:to_do_app/pages/task_data.dart';

class CompletedTasksPage extends StatefulWidget {
  final List<TaskData> completedTasks;
  final Function(List<TaskData>) onRestoreTasks; // Callback for restoring tasks

  const CompletedTasksPage({
    Key? key,
    required this.completedTasks,
    required this.onRestoreTasks,
  }) : super(key: key);

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  final Set<int> _selectedTasks = {}; // Track selected task indices
  bool _selectAll = false; // Track "Select All" state
  bool _isSelectionMode = false; // Track selection mode

  // Toggle selection for a single task
  void _toggleTaskSelection(int index) {
    setState(() {
      if (_selectedTasks.contains(index)) {
        _selectedTasks.remove(index);
      } else {
        _selectedTasks.add(index);
      }

      // Exit selection mode if no tasks are selected
      if (_selectedTasks.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  // Select or Deselect all tasks
  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedTasks.addAll(List.generate(widget.completedTasks.length, (i) => i));
      } else {
        _selectedTasks.clear();
      }

      // Exit selection mode if "Select All" is deselected
      if (_selectedTasks.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  // Delete selected tasks
  // Delete selected tasks
  void _deleteSelectedTasks() {
    setState(() {
      // Create a sorted list of indices to delete (descending order)
      final List<int> indicesToDelete = _selectedTasks.toList()..sort((a, b) => b.compareTo(a));

      // Remove each task from the completedTasks list
      for (int index in indicesToDelete) {
        widget.completedTasks.removeAt(index);
      }

      // Clear the selection and exit selection mode
      _selectedTasks.clear();
      _selectAll = false;
      _isSelectionMode = false;
    });
  }


  // Restore selected tasks
  void _restoreSelectedTasks() {
    setState(() {
      // Get the selected tasks
      List<TaskData> tasksToRestore = _selectedTasks.map((index) => widget.completedTasks[index]).toList();

      // Remove tasks from the completed list
      widget.completedTasks.removeWhere((task) => tasksToRestore.contains(task));

      // Clear selection and reset selection mode
      _selectedTasks.clear();
      _selectAll = false;
      _isSelectionMode = false;

      // Call the callback to restore tasks to the main list
      widget.onRestoreTasks(tasksToRestore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'Completed Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(thickness: 1, color: Colors.black54),

          // "Select All" and Action Buttons
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isSelectionMode ? 50.0 : 0.0, // Dynamic height for buttons
            child: _isSelectionMode
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _selectAll,
                        onChanged: (_) => _toggleSelectAll(),
                      ),
                      Text('Select All'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _restoreSelectedTasks,
                        icon: Icon(Icons.restore, color: Colors.blue),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: _deleteSelectedTasks,
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            )
                : SizedBox.shrink(),
          ),

          // Task List with Dynamic Checkboxes
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Exit selection mode when tapping outside
                if (_isSelectionMode) {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedTasks.clear();
                    _selectAll = false;
                  });
                }
              },
              child: ListView.builder(
                itemCount: widget.completedTasks.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedTasks.contains(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        // Show Checkbox only in Selection Mode
                        if (_isSelectionMode)
                          AnimatedOpacity(
                            opacity: _isSelectionMode ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (_) => _toggleTaskSelection(index),
                            ),
                          ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_isSelectionMode) {
                                _toggleTaskSelection(index); // Toggle selection on tap
                              }
                            },
                            onLongPress: () {
                              setState(() {
                                _isSelectionMode = true; // Enable selection mode
                                _toggleTaskSelection(index);
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue[100] : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              child: Text(
                                widget.completedTasks[index].taskText,
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
