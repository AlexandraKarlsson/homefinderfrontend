import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import './add_image.dart';

class ImageInfo {
  final File file;
  final String name;

  ImageInfo(this.file, this.name);
}

class AddImages extends StatefulWidget {
  static const PATH = 'addImages';
  int _homeId;

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<ImageInfo> _imageFiles = List<ImageInfo>();

  @override
  Widget build(BuildContext context) {
    widget._homeId = ModalRoute.of(context).settings.arguments;
    print('_homeId = ${widget._homeId}');

    return Scaffold(
      appBar: AppBar(title: Text('Lägg till bilder')),
      body: ListView.builder(
          itemCount: _imageFiles.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(_imageFiles[index].name);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addImage(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue[300],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _imageFiles.forEach((imageInfo) {
                  print('Uploading image');
                  // TODO: upload picture to homefinderimages
                  print(
                      'Inserting imagename in database with foreign key =homeid');
                  var imageData = {
                    "imagename": imageInfo.name,
                    "homeid": widget._homeId
                  };
                  _saveImage(imageData);
                  // TODO: add filename to database
                });
                // TODO: Navigating back to homelist page
                //Navigator.pushNamed(context, AddImages.PATH, arguments: homeId);
              },
            ),
          ],
        ),
      ),
    );
  }

  _addImage(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final _imageFile = await Navigator.pushNamed(context, AddImage.PATH);
    String imageName = 'house-${widget._homeId}_${_imageFiles.length + 4}';
    ImageInfo image = ImageInfo(_imageFile, imageName);
    print('imageFile = ${image.file}, imageName = ${image.name}');
    _imageFiles.add(image);
  }

  Future<void> _saveImage(dynamic image) async {
    var url = 'http://10.0.2.2:8000/image';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };

    var newImageJson = convert.jsonEncode(image);
    print('newImageJson = $newImageJson');

    // Await the http get response, then decode the json-formatted response.
    final response = await http.post(
      url,
      headers: headers,
      body: newImageJson,
    );
    if (response.statusCode == 201) {
      print('response ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
