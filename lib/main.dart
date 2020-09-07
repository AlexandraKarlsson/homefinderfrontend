import 'package:flutter/material.dart';
import 'package:homefinderfrontend/data/apartments.dart';
import 'package:provider/provider.dart';

import 'pages/add_house.dart';
import 'pages/add_apartment.dart';
import 'pages/add_images.dart';
import 'pages/add_image.dart';
import 'pages/home_list.dart';
import 'pages/login.dart';
import 'pages/add_user.dart';
import 'pages/make_bid.dart';

import 'data/settings.dart';
import 'data/brokers.dart';
import 'data/user.dart';
import 'data/apartments.dart';
import 'data/houses.dart';
import 'data/favorites.dart';

import 'test.dart';
import 'playground/popup.dart';
import 'playground/spinner_page.dart';
import 'playground/hero_animation_from.dart';
import 'playground/animation_page.dart';

/*
To start the emulator:
> emulator.exe -avd Nexus_6_API_29
*/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('build in myApp running...');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Settings>(create: (_) => Settings()),
        ChangeNotifierProvider<User>(create: (_) => User()),
        ChangeNotifierProvider<Favorites>(create: (_) => Favorites()),
        ChangeNotifierProvider<Apartments>(create: (_) => Apartments()),
        ChangeNotifierProvider<Houses>(create: (_) => Houses()),
        Provider<Brokers>(create: (_) => Brokers()),        
      ],

      child: MaterialApp(
        title: 'Hitta hemmet',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        // initialRoute: HeroAnimationFrom.PATH,
        // initialRoute: AnimationPage.PATH,
        routes: {
          '/': (context) => HomeList(),
          HomeList.PATH: (context) => HomeList(),
          AddHouse.PATH: (context) => AddHouse(),
          AddApartment.PATH: (context) => AddApartment(),
          AddImages.PATH: (context) => AddImages(),
          AddImage.PATH: (context) => AddImage(),
          AddUser.PATH: (context) => AddUser(),
          Login.PATH: (context) => Login(),
          MakeBid.PATH: (context) => MakeBid(),
          // HomeDetail.HOME_PATH: (context) => HomeDetail(),
          Test.TEST_PATH: (context) => Test(),
          PopUp.PATH: (context) => PopUp(),
          HeroAnimationFrom.PATH: (context) => HeroAnimationFrom(),
          SpinnerPage.PATH: (context) => SpinnerPage(),
          AnimationPage.PATH: (context) => AnimationPage(),
        },
      ),
    );
  }
}
