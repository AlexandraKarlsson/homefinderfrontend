import 'package:flutter/material.dart';
import 'icon_animation.dart';

class AnimationPage extends StatelessWidget {
  static String PATH = 'spinner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated icons test')),
      body: Container(
        child: IconAnimation(),
      ),
    );
  }
}
