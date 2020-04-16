import 'package:flutter/material.dart';

const navigationStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class AddHome extends StatefulWidget {
  static const PATH = 'add';

  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  bool _isSaving = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildHouseForm(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                // icon: Icon(Icons.person),
                // hintText: 'Wha',
                labelText: 'Adress',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i adressen' : null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                // icon: Icon(Icons.person),
                // hintText: 'Wha',
                labelText: 'Pris',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.isEmpty ? 'Var vänlig och fyll i pris' : null;
              },
            ),
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _isSaving = true;
                  });
                  // TODO: access and send data to backend
                  saveData().then((_) {
                    setState(() {
                      _isSaving = false;
                    });
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

  Future<void> saveData() async {
    await new Future.delayed(const Duration(seconds: 5));
  }

  Widget buildApartmentForm() {
    return Container(
      color: Colors.blue[50],
      child: Text('Build Apartment!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isSaving) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Lägg till hem')),
        body: _selectedIndex == 0
            ? buildHouseForm(context)
            : buildApartmentForm(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              icon: Icon(Icons.home),
              title: Text('Hus', style: navigationStyle),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlue,
              icon: Icon(Icons.business),
              title: Text('Lägenhet', style: navigationStyle),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
