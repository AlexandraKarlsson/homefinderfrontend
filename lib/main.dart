import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/add_home.dart';
import './pages/home_list.dart';
import './data/settings.dart';
import 'test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    print('build in myApp running...');

    return ChangeNotifierProvider<Settings>(
      create: (context) => Settings(),
      child: MaterialApp(
        title: 'Hitta hemmet',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeList(),
          AddHome.PATH: (context) => AddHome(),
          // HomeDetail.HOME_PATH: (context) => HomeDetail(),
          Test.TEST_PATH: (context) => Test(),
        },
      ),
    );
  }
}
