import 'package:flutter/material.dart';
import '../data/apartments.dart';

Apartments apartments = Apartments();

class Home extends StatelessWidget {
  static const HOME_PATH = 'home';

  @override
  Widget build(BuildContext context) {
    final apartment = apartments.apartments[0];

    return Scaffold(
        appBar: AppBar(
          title: Text('${apartment.address} lgh ${apartment.apartmentNumber}'),
        ),
        body: Column(children: <Widget>[
          // TODO: add guesture detector to handle multiple images
          Image.asset(
            'assets/images/${apartment.image}',
          ),
          // TODO: add expand button  (handle to long descriptions)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(apartment.description),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Text('Antal rum:')),
                          Expanded(child: Text('${apartment.rooms} st'))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Text('Boarea:')),
                          Expanded(child: Text('${apartment.livingSpace} kvm'))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text('Byggnadsår:')),
                          Expanded(child: Text('${apartment.built}')),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Text('Pris:')),
                          Expanded(child: Text('${apartment.price} kr')),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text('Hyra:')),
                          Expanded(child: Text('${apartment.charge} kr/mån')),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text('Driftkostnad:')),
                          Expanded(child: Text('${apartment.operationCost} kr/mån')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
