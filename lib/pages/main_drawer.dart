import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_list.dart';
import 'add_house.dart';
import 'add_apartment.dart';

import '../data/settings.dart';
import '../data/user.dart';

class MainDrawer extends StatefulWidget {
  final String search;
  MainDrawer(this.search);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.search);
  }

  @override
  Widget build(BuildContext context) {
    Settings settings = Provider.of<Settings>(context);
    User user = Provider.of<User>(context);

    return Container(
      height: double.infinity,
      width: 250,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                'Dina filter',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 19,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Sök på address',
                  isDense: true,
                ),
                controller: controller,
                onChanged: (value) {
                  print('search=$value');
                  // controller.text = value;
                  settings.changeSearchString(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                title: new Text('Lägenhet'),
                value: settings.showApartment,
                onChanged: (value) {
                  settings.changeShowApartment(value);
                },
                dense: true,
                activeColor: Colors.green,
              ),
              CheckboxListTile(
                title: new Text('Hus'),
                value: settings.showHouse,
                onChanged: (value) {
                  settings.changeShowHouse(value);
                },
                dense: true,
                activeColor: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeList(),
                        ),
                      );
                    },
                    child: const Text('Ok', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
          user.token != null ?
          Column(
            children: <Widget>[
              Text('Lägg ut hem till försäljning:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddHouse.PATH);                        
                      },
                      child: const Text('Hus', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddApartment.PATH);
                      },
                      child: const Text('Lägenhet', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
