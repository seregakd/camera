import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class CorrectPicture extends StatefulWidget {
  final String routDisplayPicture;

  CorrectPicture({this.routDisplayPicture});

  @override
  CorrectPictureState createState() => CorrectPictureState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class CorrectPictureState extends State<CorrectPicture> {
  AppState state;
  File imageFile;
//  File sourceImageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
//    final String picturePath = ModalRoute.of(context).settings.arguments;
//    sourceImageFile = File(ModalRoute.of(context).settings.arguments);
//    imageFile == null ? sourceImageFile : null;
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
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

}
/*
body: Center(
child: Image.file(File(picturePath)),
),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          widget.routDisplayPicture,
          (Route<dynamic> route) => false,
          arguments: picturePath,
        ),
 */