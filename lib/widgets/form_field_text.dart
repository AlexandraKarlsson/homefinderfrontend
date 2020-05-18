import 'package:flutter/material.dart';

class FormFieldText extends StatelessWidget {
  final String label;
  final Function onSave;
  final int maxLines;

  FormFieldText(
      {@required this.label, @required this.onSave, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      maxLines: maxLines,
      onSaved: onSave,
      validator: (String value) {
        return value.isEmpty ? 'Var vänlig och fyll i en $label' : null;
      },
    );
  }
}
