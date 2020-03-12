import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../CameraService2.dart';

class TakePicture extends StatefulWidget {
  final String routDisplayPicture;

  TakePicture({this.routDisplayPicture});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  CameraController _controller;

  final bool _platformIsIos = platformIsIos();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () => getPicture(context, _platformIsIos, _controller, widget.routDisplayPicture),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}