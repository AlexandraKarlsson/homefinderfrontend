import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../widgets/form_field_text.dart';
import '../data/user.dart';
import 'add_user.dart';

class LoginData {
  String email;
  String password;
}

class Login extends StatefulWidget {
  static const PATH = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  LoginData loginData = LoginData();
  bool _isSaving = false;

  Future<void> saveData(BuildContext context) async {
    var url = 'http://10.0.2.2:8000/user/login';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var login = {
      'email': loginData.email,
      'password': loginData.password,
    };

    var loginJson = convert.jsonEncode(login);
    print('loginJson = $loginJson');

    final response = await http.post(
      url,
      headers: headers,
      body: loginJson,
    );
    if (response.statusCode == 200) {
      print('response ${response.body}');
      var responseData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('responseData $responseData');

      String token = response.headers['x-auth'];
      User loggedInUser = Provider.of<User>(context);

      String email = responseData['user']['email'];
      String username = responseData['user']['username'];
      print('email, $email');
      print('username, $username');
      print('token, $token');

      loggedInUser.set(username, email, token);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logga in'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.blue[50],
        child: Form(
          key: this._formKey,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Hero(
                  tag: 'account',
                  child: Icon(Icons.account_circle, size: 90),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      FormFieldText(
                          label: 'Email',
                          onSave: (String value) {
                            loginData.email = value;
                          }),
                      FormFieldText(
                        label: 'Lösenord',
                        onSave: (String value) {
                          loginData.password = value;
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
                    setState(() {
                      _isSaving = true;
                    });
                    saveData(context).then((_) {
                      setState(() {
                        _isSaving = false;
                      });
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text('Logga in'),
              ),
              Text('Inget konto?'),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 3),
                        pageBuilder: (_, __, ___) => AddUser(),
                      ),
                    );
                  },
                  child: Text('Skapa konto')),
            ],
          ),
        ),
      ),
    );
  }
}
