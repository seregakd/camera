import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../Services.dart';

class DisplayPicture extends StatelessWidget{
  final String routInitCamera;
  final String routCorrectPicture;

  DisplayPicture({this.routInitCamera, this.routCorrectPicture});

  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    if (picturePath != null) {
       return Scaffold(
          appBar: AppBar(
              title: _buildTitle(context, picturePath)
          ),
          body: _viewImage(picturePath), //Image.file(File(picturePath)),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.pushNamed(context, routInitCamera);
            },
          )
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            title: Text('Take a picture')
        ),
        floatingActionButton: Center(
          child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.pushNamed(context, routInitCamera);
                },
              )
          ),
        ),
      );
    }
  }

  Future<void> _recognizeText(BuildContext context, String picturePath) async {
    final File imageFile = File(picturePath);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    viewShowDialog(context, text);
    print("Recognizer  text:" + text);

    textRecognizer.close();
  }

  Widget _buildTitle(BuildContext context, String picturePath) {
    return Row(children: <Widget>[
      RaisedButton(
        onPressed: () => _recognizeText(context, picturePath),
        child: Text('Recognize text'),
      ),
      RaisedButton(
        onPressed: () => Navigator.pushNamed(context, routCorrectPicture, arguments: picturePath),
        child: Text('Correct picture'),
      ),
    ]);
  }

  Widget _viewImage(String picturePath) {
    return Center(
      child: Image.file(File(picturePath)),
    );

/*
      AspectRatio(
        aspectRatio: 487 / 451,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: FileImage(File(picturePath)),
              ),
            )),
      );
 */
  }

}