import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'CameraService.dart';

class InitCamera extends StatelessWidget  {
  final String routTakePicture;
  final BuildContext context;

  InitCamera({this.routTakePicture, this.context}){
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    CameraController _controller = await getCameraController();

    _controller.initialize().then((_) {
       Navigator.pushReplacementNamed(context, routTakePicture,
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