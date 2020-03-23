import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import '../data/apartment.dart';
import '../data/house.dart';
import '../widgets/image_viewer.dart';
import '../data/home.dart';

class HomeDetail extends StatefulWidget {
  static const HOME_PATH = 'home';
  final Home home;

  HomeDetail(this.home);

  @override
  _HomeDetailState createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    String appBarText;
    String chargeOrPlotSize;

    if (widget.home is Apartment) {
      Apartment apartment = widget.home as Apartment;
      appBarText = '${apartment.address} lgh ${apartment.apartmentNumber}';
      chargeOrPlotSize = '${apartment.charge} kr/mån';
    } else {
      appBarText =
          '${widget.home.address} lgh ${(widget.home as House).cadastral}';
      chargeOrPlotSize = '${(widget.home as House).plotSize} kvm';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarText),
        ),
        body: Container(
          color: Colors.blue[50],
          child: Column(children: <Widget>[
            ImageViewer(widget.home.images),
            Expanded(
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ReadMoreText(widget.home.description),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
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
                                        child: Text('${widget.home.rooms} st'))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(child: Text('Boarea:')),
                                    Expanded(
                                        child: Text(
                                            '${widget.home.livingSpace} kvm'))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text('Byggnadsår:')),
                                    Expanded(
                                        child: Text('${widget.home.built}')),
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
                                            widget.home.price))),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(widget.home is Apartment
                                            ? 'Hyra:'
                                            : 'Tomtarea:')),
                                    Expanded(child: Text(chargeOrPlotSize)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Text('Driftkostnad:')),
                                    Expanded(
                                        child: Text(
                                            '${widget.home.operationCost} kr/mån')),
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
