import 'package:flutter/material.dart';
import '../data/image_data.dart';

class AddImageItem extends StatelessWidget {
  final ImageData imageData;

  const AddImageItem(this.imageData);

  @override
  Widget build(BuildContext context) {
    // print(home.image);

    return Container(
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Image.file(imageData.file),
          title: Text(
            imageData.name,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
