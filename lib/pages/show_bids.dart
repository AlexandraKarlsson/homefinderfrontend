import 'package:flutter/material.dart';

class ShowBids extends StatelessWidget {
  static const String PATH = 'showBids';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visa bud sidan')),
      body: Container(
        child:Text('Här har du dina bud'),
      ),
    );
  }
}