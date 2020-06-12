import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/house_data.dart';
import '../data/user.dart';
import '../data/home_args.dart';
import './add_images.dart';

import '../widgets/form_field_text.dart';
import '../widgets/form_field_number.dart';
import '../widgets/form_field_dropdown.dart';

const navigationStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class AddHouse extends StatefulWidget {
  static const PATH = 'addHouse';

  @override
  _AddHouseState createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  final _formKey = GlobalKey<FormState>();
  ApartmentData houseData = ApartmentData();
  int homeId;

  bool _isSaving = false;

  Future<void> saveData(User user) async {
    var url = 'http://10.0.2.2:8000/house';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': user.token
    };
    var newHouseData = {
      'address': houseData.address,
      'description': houseData.description,
      'livingspace': houseData.livingSpace,
      'rooms': houseData.rooms,
      'built': houseData.built,
      'price': houseData.price,
      'operationcost': houseData.operationCost,
      'brokerid': houseData.brokerId,
      'cadastral': houseData.cadastral,
      'structure': houseData.structure,
      'plotsize': houseData.plotSize,
      'ground': houseData.ground
    };

    var newHouseDataJson = convert.jsonEncode(newHouseData);
    // print('NewHouseDataJson = $newHouseDataJson');

    final response = await http.post(
      url,
      headers: headers,
      body: newHouseDataJson,
    );
    if (response.statusCode == 201) {
      // print('response ${response.body}');
      var responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      homeId = responseData['homeId'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget buildHouseForm(BuildContext context) {
    User user = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.blue[50],
      child: Form(
        key: this._formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FormFieldText(
                        label: 'Adress',
                        onSave: (String value) {
                          houseData.address = value;
                        }),
                    FormFieldText(
                      label: 'Beskrivning',
                      onSave: (String value) {
                        houseData.description = value;
                      },
                      maxLines: 4,
                    ),
                    FormFieldNumber(
                        label: 'Boarea',
                        onSave: (String value) {
                          houseData.livingSpace = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Antal rum',
                        onSave: (String value) {
                          houseData.rooms = double.parse(value);
                        },
                        isInteger: false),
                    FormFieldNumber(
                        label: 'Byggnadsår',
                        onSave: (String value) {
                          houseData.built = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Pris',
                        onSave: (String value) {
                          houseData.price = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Driftkostnad',
                        onSave: (String value) {
                          houseData.operationCost = int.parse(value);
                        }),
                    FormFieldText(
                        label: 'Fastighetsbeteckning',
                        onSave: (String value) {
                          houseData.cadastral = value;
                        }),
                    FormFieldText(
                        label: 'Byggnadstyp',
                        onSave: (String value) {
                          houseData.structure = value;
                        }),
                    FormFieldNumber(
                        label: 'Tomtarea',
                        onSave: (String value) {
                          houseData.plotSize = int.parse(value);
                        }),
                    FormFieldText(
                        label: 'Grund',
                        onSave: (String value) {
                          houseData.ground = value;
                        }),
                    FormFieldDropdown((String value) {
                      setState(() {
                        houseData.brokerId = int.parse(value);
                      });
                    }, () {
                      return houseData.brokerId.toString();
                    }),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  setState(() {
                    _isSaving = true;
                  });
                  saveData(user).then((_) {
                    setState(() {
                      _isSaving = false;
                    });
                    Navigator.pushNamed(context, AddImages.PATH,
                        arguments: HomeArgs(homeId, HomeType.house));
                  });
                }
              },
              child: Text('Nästa'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isSaving) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Lägg till hus')),
        body: buildHouseForm(context),
      );
    }
  }
}
