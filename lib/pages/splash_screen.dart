import 'package:flutter/material.dart';
import 'package:todo_provider/pages/todos_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TodosPage(),
          ));
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash.gif'),
      ),
    );
  }
}
