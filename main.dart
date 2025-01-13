// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/theme_notifier.dart';
import 'package:to_do_app/pages/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(simpleNavy), // Pass your default theme here
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.currentTheme,
      home: HomePage(),
    );
  }
}

