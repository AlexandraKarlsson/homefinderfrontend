import 'package:flutter/material.dart';
import 'home_list.dart';

class MainDrawer extends StatefulWidget {
  bool apartment = false;
  bool house = false;

  MainDrawer(this.apartment, this.house);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 250,
      color: Colors.white,
      child: Column(
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
            onChanged: (value) {
              setState(() {
                //search = value;
              });
              print(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          CheckboxListTile(
            title: new Text('Lägenhet'),
            value: widget.apartment,
            onChanged: (value) {
              setState(() {
                widget.apartment = value;
              });
            },
            dense: true,
            activeColor: Colors.green,
          ),
          CheckboxListTile(
            title: new Text('Hus'),
            value: widget.house,
            onChanged: (value) {
              setState(() {
                widget.house = value;
              });
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
                      builder: (BuildContext context) =>
                          HomeList(widget.apartment, widget.house),
                    ),
                  );
                },
                child: const Text('Ok', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
