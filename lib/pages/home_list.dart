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
import '../data/user.dart';
import '../data/settings.dart';
import 'login.dart';

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

  void updateData() {
    setState(() {
      _isLoading = true;
    });
    fetch().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> fetch() async {
    // print('Inside fetch ...');
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

  Future<void> _logout(User user) async {
    String url = 'http://10.0.2.2:8000/user/me/token';
    var headers = <String, String>{'x-auth': user.token};
    final response = await http.delete(url, headers: headers);
    print('response status code ${response.statusCode}, body ${response.body}');
    if (response.statusCode == 200) {
      user.clear();
    } else {
      print('Logout failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      User user = Provider.of<User>(context);
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Uppdatera sidan',
              onPressed: () {
                updateData();
              },
            ),
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                user.token == null
                    ? PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.account_circle,
                              size: 30,
                              color: Colors.blue,
                            ),
                            Text("Logga in"),
                          ],
                        ),
                      )
                    : null,
                user.token != null
                    ? PopupMenuItem(
                        value: 2,
                        child: Text("Om mig"),
                      )
                    : null,
                user.token != null
                    ? PopupMenuItem(
                        value: 3,
                        child: Text("Logga ut"),
                      )
                    : null,
              ],
              icon: Hero(
                tag: 'account',
                child: Icon(
                  Icons.account_circle,
                  color: user.token != null ? Colors.lightGreen : Colors.white,
                  size: 30,
                ),
              ),
              onSelected: (value) => {
                print('Value = $value'),
                if (value == 1)
                  // navigera till login/signup sidan
                  {
                    // Navigator.pushNamed(context, Login.PATH),
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 3),
                        pageBuilder: (_, __, ___) => Login(),
                      ),
                    )
                  }
                else if (value == 2)
                  {print('Om mig NOT IMPLEMENTED')}
                else if (value == 3)
                  {_logout(user)}
                else
                  {print('Unknown selection = $value')}
              },
            ),
          ],
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
