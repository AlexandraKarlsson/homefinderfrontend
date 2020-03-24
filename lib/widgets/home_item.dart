import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {

  final String label;
  final String value;

  HomeItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Text(label)),
        Expanded(
            child: Text(value))
      ],
    );
  }
}