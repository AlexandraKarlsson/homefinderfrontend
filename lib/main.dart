import 'package:flutter/material.dart';

import './pages/home.dart';
import './pages/home_list.dart';
import 'test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitta hemmet',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeList(),
        Home.HOME_PATH: (context) => Home(),
        Test.TEST_PATH: (context) => Test(),
      },
    );
  }
}

