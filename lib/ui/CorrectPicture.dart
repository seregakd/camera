import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class CorrectPicture extends StatefulWidget {
  final String routDisplayPicture;

  CorrectPicture({this.routDisplayPicture});

  @override
  CorrectPictureState createState() => CorrectPictureState();
}

class CorrectPictureState extends State<CorrectPicture> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      imageFile = File(ModalRoute.of(context).settings.arguments);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Correct picture")),
      body: Center(
        child: imageFile != null ? Image.file(imageFile) : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _cropImage(),
        child: Icon(Icons.crop),
      ),
    );
  }

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
}
