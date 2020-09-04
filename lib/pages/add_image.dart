import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  static const PATH = 'addImage';

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    // print('Inside _pickImage()...');
    File selected = await ImagePicker.pickImage(source: source);
    // print('selected = $selected');
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    // print('Inside _cropImage()...');
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    // print('cropped = $cropped');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    // print('_imageFile = $_imageFile');

    return Scaffold(
      appBar: AppBar(title: Text('Lägg till bilder')),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, _imageFile);
              },
              child: Icon(Icons.check),
              backgroundColor: Colors.lightBlue[300],
            ),
          ],
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
