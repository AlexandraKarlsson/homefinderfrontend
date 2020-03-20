import 'package:flutter/material.dart';
import '../pages/home_detail.dart';
import '../data/apartment.dart';
import '../data/home.dart';

class HomeItem extends StatelessWidget {

  const HomeItem({ @required this.apartment });

  final Apartment apartment;

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
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
  }
}