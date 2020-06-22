import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  static const PATH = 'popup';
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  bool isLoggedIn = false;

  Widget _simplePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          isLoggedIn == false
              ? PopupMenuItem(
                  value: 1,
                  child: Text("Logga in"),
                )
              : null,
          isLoggedIn == true
              ? PopupMenuItem(
                  value: 2,
                  child: Text("Om mig"),
                )
              : null,
          isLoggedIn == true
              ? PopupMenuItem(
                  value: 3,
                  child: Text("Logga ut"),
                )
              : null,
        ],
        icon: Icon(Icons.account_circle),
        onSelected: (value) => {
          print('Value = $value'),
          if (value == 1)
            {
              setState(() {
                isLoggedIn = true;
              })
            }
          else if (value == 2)
            {}
          else
            setState(() {
              isLoggedIn = false;
            })
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup menu example'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: null),
          _simplePopup(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[SizedBox(height: 600)],
        ),
      ),
    );
  }
}
