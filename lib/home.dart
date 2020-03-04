import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const HOME_PATH = 'home';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Column(
        children: <Widget> [
          Text('Page for home details')] 
      )
    );
  }
}