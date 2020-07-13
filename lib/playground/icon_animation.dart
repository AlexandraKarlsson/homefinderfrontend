import 'package:flutter/material.dart';

class IconAnimation extends StatefulWidget {
  _IconAnimationState createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: IconButton(
          iconSize: 70,
          icon: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: controller,
          ),
          onPressed: () => _onpressed(),
        )),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  _onpressed() {
    setState(() {
      isPlaying = !isPlaying;

      isPlaying ? controller.forward() : controller.reverse();
    });
  }
}