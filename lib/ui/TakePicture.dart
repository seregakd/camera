import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../CameraService.dart';

class TakePicture extends StatefulWidget {
  final String routDisplayPicture;
  final bool platformIsIos;

  TakePicture({this.routDisplayPicture, this.platformIsIos});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  CameraController _controller;
/*
  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }
*/
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () => getPicture(
          context, _controller,
          widget.platformIsIos,
          widget.routDisplayPicture),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}