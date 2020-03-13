import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'CameraService.dart';
import 'ui/TakePicture.dart';

class InitCamera extends StatelessWidget  {
  final String routTakePicture;

  InitCamera({this.routTakePicture}){
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    CameraController _controller = await getCameraController();

    _controller.initialize().then((_) {
/// pastle root to TakePicture
      /// Navigator.pushReplacementNamed(context, '/displayPicture',
      //              arguments: path,
      //  );
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