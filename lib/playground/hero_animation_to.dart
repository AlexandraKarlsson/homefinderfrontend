import 'package:flutter/material.dart';

class HeroAnimationTo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero animation from')),
      body: Column(
        children: <Widget>[
          Hero(
            tag: 'animation',
            child: Icon(Icons.account_circle, size: 60),
          ),
        ],
      ),
    );
  }
}
