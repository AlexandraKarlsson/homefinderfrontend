import 'package:flutter/material.dart';
import 'main_drawer.dart';
import '../widgets/home_item.dart';
import '../data/apartments.dart';

Apartments apartments = Apartments();

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  String search;

  @override
  Widget build(BuildContext context) {
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
                itemCount: apartments.apartments.length,
                itemBuilder: (BuildContext context, int index) {
                  return HomeItem(apartment: apartments.apartments[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


