import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String search = '';
  bool appartment = false;
  bool house = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: 250,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Text('Dina filter', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
            SizedBox(height: 19,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sök på address',
                isDense: true,
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
                print(value);
              },
            ),
            SizedBox(height: 20,),
            CheckboxListTile(
              title: new Text('Lägenhet'),
              value: appartment,
              onChanged: (value) {
                setState(() {
                  appartment = value;
                });
              },
              dense: true,
              activeColor: Colors.green,
            ),
            CheckboxListTile(
              title: new Text('Hus'),
              value: house,
              onChanged: (value) {
                setState(() {
                  house = value;
                });
              },
              dense: true,
              activeColor: Colors.green,
            ),
          ],
        ),
      );
  }
}