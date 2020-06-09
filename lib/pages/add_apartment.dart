import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/apartment_data.dart';
import '../data/user.dart';
import './add_images.dart';

import '../widgets/form_field_text.dart';
import '../widgets/form_field_number.dart';
import '../widgets/form_field_dropdown.dart';

const navigationStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class AddApartment extends StatefulWidget {
  static const PATH = 'addApartment';

  @override
  _AddApartmentState createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
  final _formKey = GlobalKey<FormState>();
  ApartmentData apartmentData = ApartmentData();
  int homeId;

  bool _isSaving = false;

  Future<void> saveData(User user) async {
    var url = 'http://10.0.2.2:8000/apartment';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': user.token
    };
    var newApartmentData = {
      'address': apartmentData.address,
      'description': apartmentData.description,
      'livingspace': apartmentData.livingSpace,
      'rooms': apartmentData.rooms,
      'built': apartmentData.built,
      'price': apartmentData.price,
      'operationcost': apartmentData.operationCost,
      'brokerid': apartmentData.brokerId,
      'apartmentnumber': apartmentData.apartmentNumber,
      'charge': apartmentData.charge,
    };

    var newApartmentDataJson = convert.jsonEncode(newApartmentData);
    // print('newApartmentDataJson = $newApartmentDataJson');

    final response = await http.post(
      url,
      headers: headers,
      body: newApartmentDataJson,
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

  /* List<DropdownMenuItem<String>> createDropDownMenuItems(Brokers brokers) {
    List<DropdownMenuItem<String>> menuItems = [];
    brokers.brokers.forEach((key, broker) => {
          menuItems.add(DropdownMenuItem<String>(
            child: Text(broker.name),
            value: '${broker.id}',
          ))
        });
    // menuItems.forEach((item) => {print('${item.value} : ${item.child}')});
    return menuItems;
  } */

  Widget buildApartmentForm(BuildContext context) {
    // Brokers brokers = Provider.of<Brokers>(context, listen: false);
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
                          apartmentData.address = value;
                        }),
                    FormFieldText(
                        label: 'Beskrivning',
                        onSave: (String value) {
                          apartmentData.description = value;
                        },
                        maxLines: 4),
                    FormFieldNumber(
                        label: 'Boarea',
                        onSave: (String value) {
                          apartmentData.livingSpace = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Antal rum',
                        onSave: (String value) {
                          apartmentData.rooms = double.parse(value);
                        },
                        isInteger: false),
                    FormFieldNumber(
                        label: 'Byggnadsår',
                        onSave: (String value) {
                          apartmentData.built = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Pris',
                        onSave: (String value) {
                          apartmentData.price = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Driftkostnad',
                        onSave: (String value) {
                          apartmentData.operationCost = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Lägenhetsnummer',
                        onSave: (String value) {
                          apartmentData.apartmentNumber = int.parse(value);
                        }),
                    FormFieldNumber(
                        label: 'Hyra',
                        onSave: (String value) {
                          apartmentData.charge = int.parse(value);
                        }),
                    FormFieldDropdown((String value) {
                      setState(() {
                        apartmentData.brokerId = int.parse(value);
                      });
                    }, () {
                      return apartmentData.brokerId.toString();
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
                        arguments: homeId);
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
        appBar: AppBar(title: Text('Lägg till lägenhet')),
        body: buildApartmentForm(context),
      );
    }
  }
}
