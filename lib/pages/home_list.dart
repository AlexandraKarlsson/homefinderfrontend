import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'main_drawer.dart';
import '../widgets/home_list_item.dart';
import '../data/apartments.dart';
import '../data/houses.dart';
import '../data/home.dart';
import '../data/settings.dart';

Apartments apartments = Apartments();
Houses houses = Houses();

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
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
    fetchData().then((_) {
      setState(() {
        _isInit = false;
        _isLoading = false;
      });
    });
  }

  Future<void> fetchData() async {
    await fetchApartments();
    //await fetchHouses();
    await fetchImage();
  }

  Future<void> fetchImage() async {
    var url = 'http://10.0.2.2:8000/homes/image';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('response ${response.body}');
      final imageData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      apartments.setImage(imageData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> fetchApartments() async {
    var url = 'http://10.0.2.2:8000/apartment';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('response ${response.body}');
      final apartmentData =
          convert.json.decode(response.body) as Map<String, dynamic>;
      apartments.add(apartmentData);
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
      print(
          'showApartment=${settings.showApartment}, showHouses=${settings.showHouse}, search=${settings.search},items=${homeList.length}');

      return Scaffold(
        appBar: AppBar(
          title: Text('Hitta hemmet'),
        ),
        drawer: MainDrawer(settings.search),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/apartment-1_1.jpg',
                    width: 200,
                  ),
                  Text('Strandvägen 77'),
                ],
              ),
            ),
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
