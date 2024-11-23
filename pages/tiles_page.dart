// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Tiles extends StatefulWidget {
  final String taskText; // Text of the task
  final bool hideDeleteButton; // Whether the delete button is hidden
  final VoidCallback onLongPress; // Callback for long press (show delete button)
  final VoidCallback onDelete; // Callback for deleting the task
  final ValueChanged<String> onTextChanged;// Callback for text changes
  final ValueChanged<bool> onToggleEditing; // Callback to toggle editing state
  final bool isEditing; // Whether the task is in edit mode

  const Tiles({
    required this.taskText,
    required this.hideDeleteButton,
    required this.onLongPress,
    required this.onDelete,
    required this.onTextChanged,
    required this.onToggleEditing,
    required this.isEditing,
  });

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  late TextEditingController _textController;
  bool _isChecked = false; // Checkbox state

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.taskText);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: ListTile(
            leading: Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            title: widget.isEditing
                ? TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter task',
              ),
              autofocus: true,
              onChanged: widget.onTextChanged, // Notify parent of changes
              onSubmitted: (_) {
                // Exit edit mode after submitting
                widget.onToggleEditing(false);
              },
            )
                : GestureDetector(
                  onTap: () {
                    // Enter edit mode when tapping the text
                    widget.onToggleEditing(true);
                  },
                  child: Text(
                    widget.taskText.isEmpty ? 'New Task' : widget.taskText,
                    style: TextStyle(
                    decoration: _isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    ),
                  ),
                ),
            trailing: widget.hideDeleteButton
                ? SizedBox.shrink()
                : IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: widget.onDelete,
            ),
          ),
        ),
      ),
    );
  }
}
