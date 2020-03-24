import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import '../data/apartment.dart';
import '../data/house.dart';
import '../data/home.dart';
import '../widgets/image_viewer.dart';
import '../widgets/home_item.dart';

class HomeDetail extends StatefulWidget {
  static const HOME_PATH = 'home';
  final Home home;

  HomeDetail(this.home);

  @override
  _HomeDetailState createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  List<HomeItem> buildLeftItems() {
    List<HomeItem> homeItemList = [];

    homeItemList.add(HomeItem('Antal rum:', '${widget.home.rooms} st'));
    homeItemList.add(HomeItem('Boarea:', '${widget.home.livingSpace} kvm'));
    homeItemList.add(HomeItem('Byggnadsår:', '${widget.home.built}'));

    return homeItemList;
  }

  List<HomeItem> buildRightItems() {
    List<HomeItem> homeItemList = [];

    if (widget.home is Apartment) {
      Apartment apartment = widget.home as Apartment;
      homeItemList.add(HomeItem('Pris:', Home.formatPrice(widget.home.price)));
      homeItemList.add(HomeItem('Hyra:', '${apartment.charge} kr/mån'));
      homeItemList.add(
          HomeItem('Driftkostnad:', '${widget.home.operationCost} kr/mån'));
    } else {
      House house = widget.home as House;
      homeItemList.add(HomeItem('Pris:', Home.formatPrice(widget.home.price)));
      homeItemList.add(HomeItem('Tomtarea:', '${house.plotSize} kvm'));
      homeItemList.add(
          HomeItem('Driftkostnad:', '${widget.home.operationCost} kr/mån'));
    }
    return homeItemList;
  }

  @override
  Widget build(BuildContext context) {
    String appBarText;

    if (widget.home is Apartment) {
      Apartment apartment = widget.home as Apartment;
      appBarText = '${apartment.address}, lgh ${apartment.apartmentNumber}';
    } else {
      appBarText =
          '${widget.home.address}, ${(widget.home as House).cadastral}';
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
                              children: buildLeftItems(),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Column(
                              children: buildRightItems(),
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
