import 'dart:io';

import 'package:flutter/material.dart';

class CorrectPicture extends StatefulWidget {
  final String routDisplayPicture;

  CorrectPicture({this.routDisplayPicture});

  @override
  CorrectPictureState createState() => CorrectPictureState();
}

class CorrectPictureState extends State<CorrectPicture>{

  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Correct picture")),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

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