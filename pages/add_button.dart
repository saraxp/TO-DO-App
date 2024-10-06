// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
