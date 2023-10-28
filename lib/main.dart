import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chest Infection Checker'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isInfected = false;
  File? _image;

  void checkChestInfection() {
    // You can add image processing logic here.
    // For simplicity, we'll just set the result to true.
    setState(() {
      isInfected = true;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Image Upload Widget
          if (_image != null)
            Image.file(
              _image!,
              width: 200,
              height: 200,
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick an Image from Gallery'),
          ),

          // Check Button
          ElevatedButton(
            onPressed: checkChestInfection,
            child: Text('Check'),
          ),

          // Result Text
          SizedBox(height: 20),
          isInfected
              ? Text(
                  'The chest is infected',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
