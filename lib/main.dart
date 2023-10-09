import 'package:flutter/material.dart';
import 'package:learningplus/pages/home.dart';
import 'package:learningplus/pages/login.dart';
import 'package:learningplus/pages/signup.dart';
import 'package:learningplus/pages/about.dart';
import 'package:learningplus/pages/lesson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get user => null;
  get index => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/lesson': (context) => Lesson(username: '', password: '',),
        '/about': (context) => About(username: '', password: '',),
        '/signup': (context) => Signup(user: [], index: null),
        '/home': (context) => Home(username: '', password: ''),
        '/login': (context) => Login(),
      },
      title: 'Flutter REST API MySQL',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 192, 192)),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
