import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../data/apartment_data.dart';
import '../data/house_data.dart';
import './add_images.dart';

const navigationStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class AddHouse extends StatefulWidget {
  static const PATH = 'addHouse';

  @override
  _AddHouseState createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  final _formKey = GlobalKey<FormState>();
  HouseData houseData = HouseData();
  int homeId;

  bool _isSaving = false;

    Future<void> saveData() async {
    var url = 'http://10.0.2.2:8000/house';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var newHouseData = {
      'address': houseData.address,
      'description': houseData.description,
      'livingspace': houseData.livingSpace,
      'rooms': houseData.rooms,
      'built': houseData.built,
      'price': houseData.price,
      'operationcost': houseData.operationCost,
      'cadastral': houseData.cadastral,
      'structure': houseData.structure,
      'plotsize': houseData.plotSize,
      'ground': houseData.ground
    };

    var newHouseDataJson = convert.jsonEncode(newHouseData);
    print('NewHouseDataJson = $newHouseDataJson');

    // Await the http get response, then decode the json-formatted response.
    final response = await http.post(
      url,
      headers: headers,
      body: newHouseDataJson,
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

  Widget buildHouseForm(BuildContext context) {
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
                        // icon: Icon(Icons.person),
                        // hintText: 'Wha',
                        labelText: 'Adress',
                      ),
                      onSaved: (String value) {
                        print('Address onSaved() running...');
                        houseData.address = value;
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
                        houseData.description = value;
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
                        houseData.livingSpace = int.parse(value);
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
                        houseData.rooms = double.parse(value);
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
                        houseData.built = int.parse(value);
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
                        houseData.price = int.parse(value);
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
                        houseData.operationCost = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i driftkostnaden'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Fastighetsbeteckning',
                      ),
                      onSaved: (String value) {
                        houseData.cadastral = value;
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i fastighetsbeteckning'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Byggnadstyp',
                      ),
                      onSaved: (String value) {
                        houseData.structure = value;
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll byggnadstyp'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tomtarea',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      onSaved: (String value) {
                        houseData.plotSize = int.parse(value);
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i tomtarean'
                            : null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Grund',
                      ),
                      onSaved: (String value) {
                        houseData.ground = value;
                      },
                      validator: (String value) {
                        return value.isEmpty
                            ? 'Var vänlig och fyll i grund'
                            : null;
                      },
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
                  print('House address = ${houseData.address}');
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
              child: Text('Submit'),
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
        appBar: AppBar(title: Text('Lägg till hem')),
        body: buildHouseForm(context),
      );
    }
  }
}

/* TextFormField(
              decoration: const InputDecoration(
                labelText: 'Boarea',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i boarea' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Antal rum',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i antal rum' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Byggnadsår',
              ),
              onSaved: (String value) {},
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
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i pris' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Driftkostnad',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i driftkostnaden' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Fastighetsbeteckning',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i fastighetsbeteckning' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Byggnadstyp',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll byggnadstyp' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tomtarea',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i tomtarean' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Grund',
              ),
              onSaved: (String value) {},
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i grund' : null;
              },
            ), */
