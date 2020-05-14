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

// Apartments apartments = Apartments();
// Houses houses = Houses();

class HomeList extends StatefulWidget {
  static const PATH = 'list';

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Brokers brokers;
  Apartments apartments; //  = Apartments();
  Houses houses; //  = Houses();

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('initState running...');

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    fetchData().then((_) {
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> fetchData() async {
    //if (apartments == null) {
    brokers = Brokers();
    apartments = Apartments();
    houses = Houses();
    await fetchBrokers();
    await fetchApartments();
    await fetchHouses();
    Map<String, dynamic> imageMap = await fetchImage();
    setImage(imageMap);
    //}
  }

  Future<void> fetchBrokers() async {
    var url = 'http://10.0.2.2:8000/broker';

    var response = await http.get(url);
    print('response ${response.body}');
    if (response.statusCode == 200) {
      final brokerData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      brokers.add(brokerData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
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

  Future<Map<String, dynamic>> fetchImage() async {
    var url = 'http://10.0.2.2:8000/homes/image';
    Map<String, dynamic> imageData;

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print('response ${response.body}');
      imageData = convert.json.decode(response.body) as Map<String, dynamic>;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return imageData;
  }

  Future<void> fetchApartments() async {
    var url = 'http://10.0.2.2:8000/apartment';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print('response ${response.body}');
      final apartmentData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      apartments.add(apartmentData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> fetchHouses() async {
    var url = 'http://10.0.2.2:8000/house';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print('response ${response.body}');
      final houseData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      houses.add(houseData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      Settings settings = Provider.of<Settings>(context);
      Brokers brokersContext = Provider.of<Brokers>(context);
      brokers.brokers.forEach((key,broker) => {
        brokersContext.addIfNotExists(broker)
      });

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
                    return HomeListItem(
                        home: homeList[index],
                        // TODO: remove broker parameter
                        broker: brokers.brokers[homeList[index].brokerId]);
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
