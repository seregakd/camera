import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class DisplayPicture extends StatelessWidget{
//  File imageFile = null;

  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    if (picturePath != null) {
 //     imageFile = File(picturePath);
      return Scaffold(
          appBar: AppBar(title: _buildTitle(picturePath)),
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

  Future<void> _recognizeText(String picturePath) async {
    final File imageFile = File(picturePath);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    print("Recognizer  text:" + text);

    textRecognizer.close();
  }

  Widget _buildTitle([String picturePath]) {
    return RaisedButton(
      onPressed: () => _recognizeText(picturePath),
      child: Text('Recognize text'),
    );
  }
}