import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import '../data/apartment.dart';
import '../widgets/image_viewer.dart';
import '../data/home.dart';

class HomeDetail extends StatefulWidget {
  static const HOME_PATH = 'home';
  final Apartment apartment;

  HomeDetail(this.apartment);

  @override
  _HomeDetailState createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.apartment.address} lgh ${widget.apartment.apartmentNumber}'),
        ),
        body: Container(
          color: Colors.blue[50],
          child: Column(children: <Widget>[
            ImageViewer(widget.apartment.images),
            Expanded(
                          child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ReadMoreText(widget.apartment.description),
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
                                    Expanded(
                                        child:
                                            Text('${widget.apartment.rooms} st'))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(child: Text('Boarea:')),
                                    Expanded(
                                        child: Text(
                                            '${widget.apartment.livingSpace} kvm'))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text('Byggnadsår:')),
                                    Expanded(
                                        child: Text('${widget.apartment.built}')),
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
                                    Expanded(
                                        child: Text(Home.formatPrice(
                                            widget.apartment.price))),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text('Hyra:')),
                                    Expanded(
                                        child: Text(
                                            '${widget.apartment.charge} kr/mån')),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text('Driftkostnad:')),
                                    Expanded(
                                        child: Text(
                                            '${widget.apartment.operationCost} kr/mån')),
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
            ),
          ]),
        ));
  }
}
