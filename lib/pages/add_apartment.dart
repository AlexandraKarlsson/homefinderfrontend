import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/apartment_data.dart';
import './add_images.dart';
import '../data/brokers.dart';

const navigationStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class AddApartment extends StatefulWidget {
  static const PATH = 'addHouse';

  @override
  _AddApartmentState createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
  final _formKey = GlobalKey<FormState>();
  ApartmentData apartmentData = ApartmentData();
  int homeId;

  bool _isSaving = false;

  Future<void> saveData() async {
    var url = 'http://10.0.2.2:8000/apartment';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var newApartmentData = {
      'address': apartmentData.address,
      'description': apartmentData.description,
      'livingspace': apartmentData.livingSpace,
      'rooms': apartmentData.rooms,
      'built': apartmentData.built,
      'price': apartmentData.price,
      'operationcost': apartmentData.operationCost,
      'apartmentnumber': apartmentData.apartmentNumber,
      'charge': apartmentData.charge,
    };

    var newApartmentDataJson = convert.jsonEncode(newApartmentData);
    print('newApartmentDataJson = $newApartmentDataJson');

    // Await the http get response, then decode the json-formatted response.
    final response = await http.post(
      url,
      headers: headers,
      body: newApartmentDataJson,
    );
    if (response.statusCode == 201) {
      print('response ${response.body}');
      var responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      homeId = responseData['homeId'];
      print('HomeId = $homeId');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget buildApartmentForm(BuildContext context) {
    Brokers brokers = Provider.of<Brokers>(context, listen: false);
    // print('Brokers.length = ${brokers.brokers.length}');
    // print('Brokers id 1 = ${brokers.brokers[1].name}');
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Adress',
                      ),
                      onSaved: (String value) {
                        print('Address onSaved() running...');
                        apartmentData.address = value;
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i adressen'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Beskrivning',
                      ),
                      maxLines: 4,
                      onSaved: (String value) {
                        apartmentData.description = value;
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i en beskrivning'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Boarea',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        apartmentData.livingSpace = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i boarea'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Antal rum',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        //WhitelistingTextInputFormatter(RegExp('^(-?)(0|([1-9][0-9]*))(\\.[0-9]+)?\$')),
                      ],
                      onSaved: (String value) {
                        apartmentData.rooms = double.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i antal rum'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Byggnadsår',
                      ),
                      onSaved: (String value) {
                        apartmentData.built = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i byggnadsåret'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Pris',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        apartmentData.price = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i pris'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Driftkostnad',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        apartmentData.operationCost = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i driftkostnaden'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Lägenhetsnummer',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        apartmentData.apartmentNumber = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i lägenhetsnummret'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Hyra',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        apartmentData.charge = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i hyran'
                            : null;
                      },
                    ),
                    DropdownButton<String>(
                      items: createDropDownMenuItems(brokers),
                      onChanged: (String value) {
                        setState(() {
                          apartmentData.brokerId = int.parse(value);
                        });
                      },
                      hint: Text('Välj mäklare'),
                      value: apartmentData.brokerId.toString(),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print('Apartment address = ${apartmentData.address}');
                  setState(() {
                    _isSaving = true;
                  });
                  saveData().then((_) {
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

  List<DropdownMenuItem<String>> createDropDownMenuItems(Brokers brokers) {
    List<DropdownMenuItem<String>> menuItems = [];
    brokers.brokers.forEach((key, broker) => {
          menuItems.add(DropdownMenuItem<String>(
            child: Text(broker.name),
            value: '${broker.id}',
          ))
        });
    // print('End of createDropDownMenyItems length = ${menuItems.length}');
    // menuItems.forEach((item) => {print('${item.value} : ${item.child}')});
    return menuItems;
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
