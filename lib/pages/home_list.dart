import 'package:flutter/material.dart';
import 'main_drawer.dart';
import 'home_detail.dart';
import '../data/home.dart';
import '../data/apartments.dart';
import '../data/apartment.dart';

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
      body: Container(
        child: ListView.builder(
          itemCount: apartments.apartments.length,
          itemBuilder: (BuildContext context, int index) {
            Apartment apartment = apartments.apartments[index];
            return Container(
              child: Card(
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, HomeDetail.HOME_PATH);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeDetail(apartment)));
                  },
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/${apartment.image}',
                    ),
                    title: Text(
                      apartment.address,
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                        'Area: ${apartment.livingSpace}, Antal rum: ${apartment.rooms}',
                        style: TextStyle(fontSize: 12)),
                    trailing: Column(
                      children: <Widget>[
                        Text(
                          Home.formatPrice(apartment.price),
                          style: TextStyle(fontSize: 14),
                        ),
                        Icon(Icons.shopping_cart)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hitta hemmet'),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/apartment-1_1.jpg',
                  width: 200,
                ),
                Text('Strandvägen 77'),
              ],
            ),
          ],
        ),
      ),
    );
  }*/
}
