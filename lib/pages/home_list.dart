import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_drawer.dart';
import '../widgets/home_list_item.dart';
import '../data/apartments.dart';
import '../data/houses.dart';
import '../data/home.dart';
import '../data/settings.dart';

Apartments apartments = Apartments();
Houses houses = Houses();

class HomeList extends StatefulWidget {

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context);

    List<Home> homeList = List<Home>();
    if (settings.showApartment) {
      homeList.addAll(apartments.apartments);
    }
    if (settings.showHouse) {
      homeList.addAll(houses.houses);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hitta hemmet'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/apartment-1_1.jpg',
                  width: 200,
                ),
                Text('Strandvägen 77'),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: homeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return HomeListItem(home: homeList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
