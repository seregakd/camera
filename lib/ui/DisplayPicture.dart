import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_cropper/image_cropper.dart';
import '../Services.dart';

class DisplayPicture extends StatefulWidget{
  final String routInitCamera;

  DisplayPicture({this.routInitCamera});

  @override
  DisplayPictureState createState() => DisplayPictureState();
}

class DisplayPictureState extends State<DisplayPicture> {
  File imageFile;

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            showCropGrid: false,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {});
    }
  }

  Future<void> _recognizeText(BuildContext context) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = visionText.text;
    viewShowDialog(context, text);
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    if (picturePath != null) {
      if (imageFile == null) {
        imageFile = File(picturePath);
      }
       return Scaffold(
          appBar: AppBar(
              title: _buildTitle(context, picturePath)
          ),
          body: Center(
            child: Image.file(imageFile),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.crop),
            onPressed: () => _cropImage(),
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
                  Navigator.pushNamed(context, widget.routInitCamera);
                },
              )
          ),
        ),
      );
    }
  }

  Widget _buildTitle(BuildContext context, String picturePath) {
    return Row(children: <Widget>[
      RaisedButton(
        onPressed: () => Navigator.pushNamed(context, widget.routInitCamera),
        child: Text('Take picture'),
      ),
      RaisedButton(
        onPressed: () => _recognizeText(context),
        child: Text('Recognize text'),
      ),
    ]);
  }
}