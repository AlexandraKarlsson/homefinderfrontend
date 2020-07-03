import 'package:flutter/material.dart';
import 'hero_animation_to.dart';

class HeroAnimationFrom extends StatelessWidget {
  static const PATH = 'animate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero animation from')),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Hero(
            tag: 'animation',
            child: Icon(Icons.account_circle, size: 60),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 3),
                  pageBuilder: (_, __, ___) => HeroAnimationTo(),
                ),
              );

              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (BuildContext context) => HeroAnimationTo()),
              // );
            },
            child: Text('Goto next page'),
          )
        ],
      ),
    );
  }
}
