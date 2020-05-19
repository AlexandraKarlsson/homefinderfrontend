import 'package:flutter/material.dart';
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/apartment.dart';
import '../data/house.dart';
import '../data/home.dart';
import '../data/broker.dart';
import '../data/brokers.dart';
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
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    fetchImages().then((_) {
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> fetchImages() async {
    print('homeid = ${widget.home.id}');
    var url = 'http://10.0.2.2:8000/homes/${widget.home.id}/images';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print('response ${response.body}');
      Map<String, dynamic> imageData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      List<String> images = [];
      imageData['rows'].forEach((image) {
        images.add(image['imagename']);
      });
      widget.home.images = images;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  List<HomeItem> buildLeftItems() {
    List<HomeItem> homeItemList = [];

    homeItemList.add(HomeItem('Antal rum:', '${widget.home.rooms} st'));
    homeItemList.add(HomeItem('Boarea:', '${widget.home.livingSpace} kvm'));
    homeItemList.add(HomeItem('Byggnadsår:', '${widget.home.built}'));

    if (widget.home is House) {
      homeItemList
          .add(HomeItem('Byggnadstyp:', '${(widget.home as House).structure}'));
    }

    return homeItemList;
  }

  List<HomeItem> buildRightItems() {
    List<HomeItem> homeItemList = [];

    if (widget.home is Apartment) {
      Apartment apartment = widget.home as Apartment;
      homeItemList
          .add(HomeItem('Pris:', Home.formatCurrency(widget.home.price, 'kr')));
      homeItemList.add(HomeItem('Hyra:', '${apartment.charge} kr/mån'));
      homeItemList.add(HomeItem('Driftkostnad:',
          Home.formatCurrency(widget.home.operationCost, 'kr/mån')));
    } else {
      House house = widget.home as House;
      homeItemList
          .add(HomeItem('Pris:', Home.formatCurrency(widget.home.price, 'kr')));
      homeItemList.add(HomeItem('Driftkostnad:',
          Home.formatCurrency(widget.home.operationCost, 'kr/mån')));
      homeItemList.add(HomeItem('Tomtarea:', '${house.plotSize} kvm'));
      homeItemList.add(HomeItem('Grund:', '${house.ground}'));
    }
    return homeItemList;
  }

  @override
  Widget build(BuildContext context) { 

    Brokers brokers = Provider.of<Brokers>(context, listen: false); 
    Broker broker = brokers.brokers[widget.home.brokerId];   
    String appBarText;
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
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
          child: Column(
            children: <Widget>[
              ImageViewer(widget.home.images),
              Expanded(
                child: ListView(
                  children: <Widget>[
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
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
                                width: 10,
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
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    broker.name,
                    style: TextStyle(fontSize: 14),
                  ),
                  subtitle:
                      Text(broker.email, style: TextStyle(fontSize: 12)),
                  trailing:
                      Text(broker.phone, style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
