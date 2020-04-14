import 'package:flutter/material.dart';

const navigationStyle = TextStyle(fontSize: 20,fontWeight: FontWeight.bold);

class AddHome extends StatefulWidget {
  static const PATH = 'add';

  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lägg till hem')),
      body: Container(
        color: Colors.blue[50],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlue,
            icon: Icon(Icons.home),
            title: Text('Hus', style: navigationStyle),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.lightBlue,
            icon: Icon(Icons.business),
            title: Text('Lägenhet', style: navigationStyle),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
