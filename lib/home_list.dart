import 'package:flutter/material.dart';
import 'main_drawer.dart';
import 'home.dart';

class HomeList extends StatefulWidget {

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  String search;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Hitta hemmet'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('assets/images/flat1.jpg',width: 200,),
                Text('Strandvägen 77'),
              ],
            ),
            Card(            
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Home.HOME_PATH);
                },
                child: ListTile(leading:  Image.asset('assets/images/flat1.jpg',),
                title: Text('Strandvägen 77, Stockholm',style: TextStyle(fontSize: 14),),
                subtitle: Text('Area: 180 kvm, Antal rum: 5',style: TextStyle(fontSize: 12)),
                trailing: Column(children : <Widget>[
                  Text('10 950 000 kr',style: TextStyle(fontSize: 14),),
                  Icon(Icons.shopping_cart)
                ],),),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(leading:  Image.asset('assets/images/flat1.jpg',),
                title: Text('Strandvägen 77, Stockholm',style: TextStyle(fontSize: 14),),
                subtitle: Text('Area: 180 kvm, Antal rum: 5, Boendetyp: Lägenhet, ',style: TextStyle(fontSize: 12)),
                isThreeLine: true,
                trailing: Column(children : <Widget>[
                  Text('10 950 000 kr',style: TextStyle(fontSize: 14),),
                  Icon(Icons.shopping_cart)
                ],),),
            ),
          ],
        ),
      ),
    );
  }
}
