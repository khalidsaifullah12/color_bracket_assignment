<<<<<<< HEAD
import 'package:color_bracket_assignment/view/login_screen.dart';
=======

>>>>>>> 119504b (Initial commit)
import 'package:color_bracket_assignment/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Flutter Demo',
=======
      title: 'Employee Tracker',
>>>>>>> 119504b (Initial commit)
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,



      ),
home: const SplahScreen(),
    );
  }
}

