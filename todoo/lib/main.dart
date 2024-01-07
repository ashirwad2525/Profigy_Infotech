// main.dart

import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      home: TaskListScreen(),
    );
  }
}
