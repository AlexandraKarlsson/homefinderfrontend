import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/brokers.dart';

class FormFieldDropdown extends StatelessWidget {
  final Function onChanged;
  final Function getValue;

  FormFieldDropdown(@required this.onChanged, @required this.getValue);

  List<DropdownMenuItem<String>> createDropDownMenuItems(Brokers brokers) {
    List<DropdownMenuItem<String>> menuItems = [];
    brokers.brokers.forEach((key, broker) => {
          menuItems.add(DropdownMenuItem<String>(
            child: Text(broker.name),
            value: '${broker.id}',
          ))
        });
    // menuItems.forEach((item) => {print('${item.value} : ${item.child}')});
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    Brokers brokers = Provider.of<Brokers>(context, listen: false);
    return DropdownButton<String>(
      items: createDropDownMenuItems(brokers),
      onChanged: onChanged,
      hint: Text('Välj mäklare'),
      value: getValue(),
    );
  }
}
