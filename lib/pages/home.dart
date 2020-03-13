import 'package:flutter/material.dart';
import '../data/apartments.dart';
import '../widgets/image_viewer.dart';

Apartments apartments = Apartments();

class Home extends StatefulWidget {
  static const HOME_PATH = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int imageIndex = 0;

  void switchImage() {}

  @override
  Widget build(BuildContext context) {
    final apartment = apartments.apartments[0];

    return Scaffold(
        appBar: AppBar(
          title: Text('${apartment.address} lgh ${apartment.apartmentNumber}'),
        ),
        body: Container(
          color: Colors.blue[50],
          child: Column(children: <Widget>[
            ImageViewer(apartment.images),      
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(apartment.description),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(4),
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
                                Expanded(
                                    child: Text('${apartment.livingSpace} kvm'))
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
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('Pris:')),
                                // TODO: format price
                                Expanded(child: Text('${apartment.price} kr')),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('Hyra:')),
                                Expanded(
                                    child: Text('${apartment.charge} kr/mån')),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('Driftkostnad:')),
                                Expanded(
                                    child: Text(
                                        '${apartment.operationCost} kr/mån')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
