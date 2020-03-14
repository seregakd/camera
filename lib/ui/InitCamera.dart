import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../CameraService.dart';

class InitCamera extends StatefulWidget  {
  final String routTakePicture;

  InitCamera({this.routTakePicture});

    @override
    InitCameraState createState() => InitCameraState();
  }

class InitCameraState extends State<InitCamera> {

  @override
  void initState() {
    super.initState();
      _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    CameraController _controller = await getCameraController();
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(
        context,
        widget.routTakePicture,
        arguments: _controller,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wait...')),
      body: Center(child: CircularProgressIndicator())
    );
  }
}