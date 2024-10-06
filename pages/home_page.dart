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
  List<Widget> _widgets = [
    Tiles(),
  ];

  void _addWidgets() {
    setState(() {
      _widgets.add(Tiles());
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
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: _widgets.length,
              itemBuilder: (context, index) {
                return _widgets[index];
              }),
        ),
        AddButton(onPressed: () => _addWidgets()),
      ]),
    );
  }
}
