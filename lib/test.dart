import 'package:flutter/material.dart';

const gridTextStyle = TextStyle(color: Colors.black, fontSize: 16);

class Test extends StatelessWidget {
  static const TEST_PATH = 'test';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('He\'d have you all unravel at the', style: gridTextStyle),
                  color: Colors.green[100],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Heed not the rabble', style: gridTextStyle),
                  color: Colors.green[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Sound of screams but the', style: gridTextStyle),
                  color: Colors.green[300],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Who scream', style: gridTextStyle),
                  color: Colors.green[400],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution is coming...', style: gridTextStyle),
                  color: Colors.green[500],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution, they...', style: gridTextStyle),
                  color: Colors.green[600],
                ),
              ],
            ),
          ),
        ],
      
    );
  }
}