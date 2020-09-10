import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../widgets/form_field_text.dart';
import '../widgets/show_dialog_message.dart';

class UserData {
  String username;
  String email;
  String password;
  String verifyPassword;
}

class AddUser extends StatefulWidget {
  static const PATH = 'addUser';

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  UserData userData = UserData();
  bool _isSaving = false;

  Future<void> saveData(BuildContext context) async {
    var url = 'http://10.0.2.2:8000/user';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var newUser = {
      'username': userData.username,
      'email': userData.email,
      'password': userData.password,
    };

    var newUserJson = convert.jsonEncode(newUser);
    print('newUserJson = $newUserJson');

    final response = await http.post(
      url,
      headers: headers,
      body: newUserJson,
    );
    if (response.statusCode == 201) {
      print('response ${response.body}');
      var responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('responseData $responseData');
      
      // TODO: Create method based on the code below in dhow_dialgot_message
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.gavel),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Användaren skapad!'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Request failed with status: ${response.statusCode}.');
      // TODO: Create method based on the code below in dhow_dialgot_message
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(Icons.gavel),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Gick inte att skapa användaren!'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSaving
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Skapa användare'),
            ),
            body: Container(
              padding: EdgeInsets.all(8),
              color: Colors.blue[50],
              child: Form(
                key: this._formKey,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: 'account',
                        child: Icon(Icons.account_circle, size: 30),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            FormFieldText(
                                label: 'Användarnamn',
                                onSave: (String value) {
                                  userData.username = value;
                                }),
                            FormFieldText(
                                label: 'Email',
                                onSave: (String value) {
                                  userData.email = value;
                                }),
                            FormFieldText(
                              label: 'Lösenord',
                              onSave: (String value) {
                                userData.password = value;
                              },
                              obscureText: true,
                            ),
                            FormFieldText(
                              label: 'Verifiera lösenord',
                              onSave: (String value) {
                                userData.verifyPassword = value;
                              },
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (userData.password == userData.verifyPassword) {
                            setState(() {
                              _isSaving = true;
                            });
                            saveData(context).then((_) {
                              setState(() {
                                _isSaving = false;
                              });
                              Navigator.of(context).pop();
                            });
                          } else {
                            showDialogMessage(
                              context,
                              "Felmeddelande",
                              "Lösenorden matchar inte, var vänlig försök igen!",
                            );
                          }
                        }
                      },
                      child: Text('Skapa'),
                    ),
                  ],
                ),
              ),
            ),
          );
    //}
  }
}
