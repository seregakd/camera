import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class DisplayPicture extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    if (picturePath != null) {
      return Scaffold(
          appBar: AppBar(title: _buildTitle()),
          body: Center(
            child: Image.file(File(picturePath)),
          ),
          floatingActionButton: FloatingActionButton(
            child:
            Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.pushNamed(context, '/takePicture');
            },
          )
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Take a picture')),
        floatingActionButton:
        Center(
          child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.pushNamed(context, '/takePicture');
                },
              )
          ),
        ),
      );
    }
  }
}

void _recognizeText(bool value) {

}

  Widget _buildTitle() {
    return RaisedButton(
      onPressed: () => _recognizeText,
      child: Text('Recognize text'),
    );
  }