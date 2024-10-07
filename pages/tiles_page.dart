// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Tiles extends StatefulWidget {
  final bool hideDeleteButton;
  final VoidCallback onLongPress;

  Tiles({
    required this.hideDeleteButton,
    required this.onLongPress,
  });

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            title: Text('blah blah blah'),
            trailing: widget.hideDeleteButton
                ? SizedBox.shrink()
                : IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Add your deletion logic here
                      print('Item deleted');
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
