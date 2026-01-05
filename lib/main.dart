import 'package:flutter/material.dart';
//import 'package:task_manager_listnow/basic_reorderable_example.dart';
import 'package:task_manager_listnow/reorderable_dismissible.dart';



void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ReorderableDismissibleList(),
    );
  }
}