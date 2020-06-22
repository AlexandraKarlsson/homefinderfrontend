import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/add_house.dart';
import 'pages/add_apartment.dart';
import 'pages/add_images.dart';
import 'pages/add_image.dart';
import 'pages/home_list.dart';
import 'pages/login.dart';
import 'pages/add_user.dart';
import 'playground/popup.dart';

import 'data/settings.dart';
import 'data/brokers.dart';
import 'data/user.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(create: (_) => Settings()),
        ChangeNotifierProvider<User>(create: (_) => User()),
        Provider<Brokers>(create: (_) => Brokers()),
      ],
      child: MaterialApp(
        title: 'Hitta hemmet',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        // initialRoute: PopUp.PATH,
        routes: {
          '/': (context) => HomeList(),
          HomeList.PATH: (context) => HomeList(),
          AddHouse.PATH: (context) => AddHouse(),
          AddApartment.PATH: (context) => AddApartment(),
          AddImages.PATH: (context) => AddImages(),
          AddImage.PATH: (context) => AddImage(),
          AddUser.PATH: (context) => AddUser(),
          Login.PATH: (context) => Login(),
          // HomeDetail.HOME_PATH: (context) => HomeDetail(),
          Test.TEST_PATH: (context) => Test(),
          PopUp.PATH: (context) => PopUp(),
        },
      ),
    );
  }
}
