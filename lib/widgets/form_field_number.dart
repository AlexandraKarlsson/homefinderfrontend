import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldNumber extends StatelessWidget {
  final String label;
  final Function onSave;
  final bool isInteger;

  FormFieldNumber({@required this.label, @required this.onSave, this.isInteger = true});

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormat = [];
    if(isInteger) {
      inputFormat = <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ];
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: inputFormat,
      onSaved: onSave,
      validator: (String value) {
        return value.isEmpty ? 'Var vänlig och fyll i $label' : null;
      },
    );
  }
}
