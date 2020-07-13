import 'package:flutter/material.dart';
//import 'spinner_widget.dart';
import 'rotated_icon.dart';
class SpinnerPage extends StatelessWidget {
  static String PATH = 'spinner';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spinner test')),
      body: Container(
        child: RotatedIcon(),
        //Spinner(icon: const Icon(Icons.home)),
      ),
    );
  }
}
