import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/add_home.dart';
import './pages/add_images.dart';
import './pages/add_image.dart';
import './pages/home_list.dart';
import './data/settings.dart';
import 'test.dart';

/*
To start the emulator:
> emulator.exe -avd Nexus_6_API_29
*/

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
          HomeList.PATH: (context) => HomeList(),
          AddHome.PATH: (context) => AddHome(),
          AddImages.PATH: (context) => AddImages(),
          AddImage.PATH: (context) => AddImage(),
          // HomeDetail.HOME_PATH: (context) => HomeDetail(),
          Test.TEST_PATH: (context) => Test(),
        },
      ),
    );
  }
}
