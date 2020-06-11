import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'add_image.dart';
import 'home_list.dart';
import '../widgets/add_image_item.dart';
import '../data/image_data.dart';
import '../data/user.dart';

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
    //print('_homeId = $_homeId');
    User user = Provider.of<User>(context);

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
                  _uploadImage(imageInfo, user);
                  var imageData = {
                    "imagename": imageInfo.name,
                    "homeid": _homeId
                  };
                  _saveImage(imageData, user);
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
    dynamic _imageFile = await Navigator.pushNamed(context, AddImage.PATH);
    String extention = _imageFile.path.split(".").last;
    String imageName = 'house-${_homeId}_${_imageFiles.length + 4}.$extention';
    ImageData image = ImageData(_imageFile, imageName);
    // print('imageFile = ${image.file}, imageName = ${image.name}');
    _imageFiles.add(image);
  }

  Future<void> _saveImage(dynamic image, User user) async {
    var url = 'http://10.0.2.2:8000/image';
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': user.token
    };

    var newImageJson = convert.jsonEncode(image);
    //print('newImageJson = $newImageJson');

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

  Future<void> _uploadImage(ImageData image, User user) async {
    final String url = 'http://10.0.2.2:8010/image';
    String base64Image = convert.base64Encode(image.file.readAsBytesSync());
    var headers = <String, String>{'x-auth': user.token};

    http.post(
      url,
      headers: headers,
      body: {
        "image": base64Image,
        "name": image.name,
      },
    ).then((response) {
      print(response.statusCode);
    }).catchError((error) {
      print(error);
    });
  }
}
