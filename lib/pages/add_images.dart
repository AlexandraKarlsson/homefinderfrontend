import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'add_image.dart';
import 'home_list.dart';
import '../widgets/add_image_item.dart';
import '../data/image_data.dart';


class AddImages extends StatefulWidget {
  static const PATH = 'addImages';

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  int _homeId;
  List<ImageData> _imageFiles = List<ImageData>();

  @override
  Widget build(BuildContext context) {
    _homeId = ModalRoute.of(context).settings.arguments;
    print('_homeId = $_homeId');

    return Scaffold(
      appBar: AppBar(title: Text('Lägg till bilder')),
      body: ListView.builder(
          itemCount: _imageFiles.length,
          itemBuilder: (BuildContext context, int index) {
            return AddImageItem(_imageFiles[index]);
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
                  _uploadImage(imageInfo);
                  print(
                      'Inserting imagename in database with foreign key =homeid');
                  var imageData = {
                    "imagename": imageInfo.name,
                    "homeid": _homeId
                  };
                  _saveImage(imageData);
                });
                Navigator.pushNamed(context, HomeList.PATH);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addImage(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    dynamic _imageFile = await Navigator.pushNamed(context, AddImage.PATH);
    String extention = _imageFile.path.split(".").last;
    String imageName = 'house-${_homeId}_${_imageFiles.length + 4}.$extention';
    ImageData image = ImageData(_imageFile, imageName);
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

 Future<void> _uploadImage(ImageData image) async {
   final String url = 'http://10.0.2.2:8010/image';
   String base64Image = convert.base64Encode(image.file.readAsBytesSync());

   http.post(url, body: {
     "image": base64Image,
     "name": image.name,
   }).then((response) {
     print(response.statusCode);
   }).catchError((error) {
     print(error);
   });
  }

}
