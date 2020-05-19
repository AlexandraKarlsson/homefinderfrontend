import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'main_drawer.dart';
import '../widgets/home_list_item.dart';
import '../data/brokers.dart';
import '../data/apartments.dart';
import '../data/apartment.dart';
import '../data/houses.dart';
import '../data/house.dart';
import '../data/home.dart';
import '../data/settings.dart';

class HomeList extends StatefulWidget {
  static const PATH = 'list';

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Brokers brokers;
  Apartments apartments;
  Houses houses;

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    fetch().then((_) {
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> fetch() async {
    brokers = Brokers();
    apartments = Apartments();
    houses = Houses();
    await fetchBrokers();
    await fetchApartments();
    await fetchHouses();
    await fetchImage();
  }

  Future<Map<String, dynamic>> fetchData(String url) async {
    var data;
    var response = await http.get(url);
    //print('response ${response.body}');
    if (response.statusCode == 200) {
      data = convert.json.decode(response.body) as Map<String, dynamic>;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return data;
  }

  Future<void> fetchBrokers() async {
    var url = 'http://10.0.2.2:8000/broker';
    final brokerData = await fetchData(url);
    brokers.add(brokerData);
  }

  void setImage(Map<String, dynamic> imageMap) {
    if (imageMap != null) {
      Map<int, String> images = {};
      imageMap['rows'].forEach((image) {
        images[image['homeid']] = image['imagename'];
      });
      // print('Image = ${images[1]}');

      for (int index = 0; index < apartments.apartments.length; index++) {
        Apartment apartment = apartments.apartments[index];
        apartment.image = images[apartment.id];
      }
      for (int index = 0; index < houses.houses.length; index++) {
        House house = houses.houses[index];
        house.image = images[house.id];
      }
    }
  }

  Future<void> fetchImage() async {
    var url = 'http://10.0.2.2:8000/homes/image';
    final imageData = await fetchData(url);
    setImage(imageData);
  }

  Future<void> fetchApartments() async {
    var url = 'http://10.0.2.2:8000/apartment';
    final apartmentData = await fetchData(url);
    apartments.add(apartmentData);
  }

  Future<void> fetchHouses() async {
    var url = 'http://10.0.2.2:8000/house';
    final houseData = await fetchData(url);
    houses.add(houseData);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      Settings settings = Provider.of<Settings>(context);
      Brokers brokersContext = Provider.of<Brokers>(context);
      brokers.brokers
          .forEach((key, broker) => {brokersContext.addIfNotExists(broker)});

      List<Home> homeListTemp = List<Home>();
      if (settings.showApartment) {
        homeListTemp.addAll(apartments.apartments);
      }
      if (settings.showHouse) {
        homeListTemp.addAll(houses.houses);
      }

      List<Home> homeList = List<Home>();
      for (int index = 0; index < homeListTemp.length; index++) {
        if (homeListTemp[index].address.startsWith(settings.search)) {
          homeList.add(homeListTemp[index]);
        }
      }
      // print('showApartment=${settings.showApartment}, showHouses=${settings.showHouse}, search=${settings.search},items=${homeList.length}');

      return Scaffold(
        appBar: AppBar(
          title: Text('Hitta hemmet'),
        ),
        drawer: MainDrawer(settings.search),
        body: Column(
          children: <Widget>[
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
}
