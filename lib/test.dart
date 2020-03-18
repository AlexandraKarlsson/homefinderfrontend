import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const TEST_PATH = 'test';

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> images = [
    'apartment-1_1.jpg',
    'apartment-1_2.jpg',
    'apartment-1_3.jpg'
  ];
  int index = 0;

  final double MIN_X_VALUE = 50;
  final double MAX_Y_FACTOR = 4;

  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              child: Image.asset(
                'assets/images/${images[index]}',
              ),
              onPanDown: (details) {
                print('onPanDown called with $details');
                x = 0;
                y = 0;
                print('x = $x, y= $y');
              },
              onPanUpdate: (details) {
                print('onPanUpdate called with $details');
                x += details.delta.dx;
                y += details.delta.dy;
                print('x = $x, y= $y');
              },
              onPanEnd: (details) {
                print('onPanEnd called with $details');
                if (x.abs() > MIN_X_VALUE &&
                    y.abs() < (x.abs() / MAX_Y_FACTOR)) {
                  if (x > 0) {
                    if (index > 0) {
                      setState(() {
                        index -= 1;
                      });
                    }

                  } else {
                    if (index < images.length - 1) {
                      setState(() {
                        index += 1;
                      });
                    }

                  }
                }
              },
              onPanCancel: () {
                print('onPanCancel called');
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              width: 25,
              child: IconButton(
                icon: index == 0
                    ? Icon(Icons.radio_button_checked,size: 15,)
                    : Icon(Icons.radio_button_unchecked,size: 15),
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
            ),
            Container(
              width: 25,
              child: IconButton(
                  icon: index == 1
                      ? Icon(Icons.radio_button_checked,size: 15,)
                      : Icon(Icons.radio_button_unchecked,size: 15,),
                  onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },),
            ),
            Container(
              width: 25,
              child: IconButton(
                  icon: index == 2
                      ? Icon(Icons.radio_button_checked,size: 15)
                      : Icon(Icons.radio_button_unchecked,size: 15),
                  onPressed: () {
                  setState(() {
                    index = 2;
                  });
                },),
            ),
          ])
        ],
      ),
    );
  }
}

/*
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
*/
