// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tiles extends StatefulWidget {
  final String taskText; // Text of the task
  final bool isReadOnly; //Flag for read-only mode
  final bool hideDeleteButton; // Whether the delete button is hidden
  final VoidCallback onLongPress; // Callback for long press (show delete button)
  final VoidCallback onDelete; // Callback for deleting the task
  final ValueChanged<String> onTextChanged;// Callback for text changes
  final ValueChanged<bool> onToggleEditing; // Callback to toggle editing state
  final bool isEditing; // Whether the task is in edit mode
  final VoidCallback onMarkAsCompleted;
  final bool isChecked; // New property for checkbox state
  final ValueChanged<bool> onCheckedChanged;// Callback for checkbox changes
  final Color? backgroundColor;

  const Tiles({
    required this.taskText,
    this.isReadOnly = false,
    required this.hideDeleteButton,
    required this.onLongPress,
    required this.onDelete,
    required this.onTextChanged,
    required this.onToggleEditing,
    required this.isEditing,
    required this.onMarkAsCompleted,
    required this.isChecked,
    required this.onCheckedChanged,
    this.backgroundColor,
  });

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  late TextEditingController _textController;

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
      onLongPress: widget.isReadOnly ? null : widget.onLongPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
        child: Card(
          color: Color(0xFFF8FAFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: ListTile(
            leading: widget.isReadOnly
              ? null //no check-box in read-only mode
              : Checkbox(
                activeColor: Color(0xFF000033),
                checkColor: Color(0xFFF8FAFC),
                value: widget.isChecked,
                onChanged: widget.isReadOnly
                  ? null
                  : (bool? value) {
                      if (value != null) {
                        widget.onCheckedChanged(value);
                        if (value) {
                          widget.onMarkAsCompleted(); // Notify parent when completed
                        }
                      }
                  },
                ),
            title: widget.isEditing && !widget.isReadOnly
                ? TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.merriweather(
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Enter task',
                  ),
                  style: GoogleFonts.merriweather(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
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
                    style: GoogleFonts.merriweather(
                      decoration: widget.isChecked && !widget.isReadOnly
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    ),
                  ),
                ),
            trailing: widget.isReadOnly
                ? null
                : widget.hideDeleteButton
                    ? null
                    : IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFF000033)),
                        onPressed: widget.onDelete,
                    ),
          ),
        ),
      ),
    );
  }
}
