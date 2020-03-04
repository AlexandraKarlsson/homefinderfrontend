import 'package:flutter/material.dart';

import 'home.dart';
import 'home_list.dart';

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
      },
    );
  }
}

