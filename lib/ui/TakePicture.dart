import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../CameraService.dart';

class TakePicture extends StatefulWidget {
  final String routDisplayPicture;

  TakePicture({this.routDisplayPicture});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final bool _platformIsIos = platformIsIos();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = await getCameraController();
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
/*
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
*/
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
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
/// correct it IF
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () => getPicture(context, _platformIsIos, _controller, widget.routDisplayPicture),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
