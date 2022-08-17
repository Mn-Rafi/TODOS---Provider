import 'package:flutter/material.dart';
import 'package:todo_provider/pages/todos_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodosPage(),
    );
  }
}
