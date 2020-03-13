import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../CameraService.dart';

class TakePicture2 extends StatefulWidget {
  final String routDisplayPicture;

  TakePicture2({this.routDisplayPicture});

  @override
  TakePicture2State createState() => TakePicture2State();
}

class TakePicture2State extends State<TakePicture2> {
  CameraController _controller;
///  Future<void> _initializeControllerFuture;
///  final bool _platformIsIos = platformIsIos();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = await getCameraController();
//    _initializeControllerFuture = _controller.initialize();
//    setState(() {});

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
/*
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
*/

  @override
  Widget build(BuildContext context) {
 //   if (!_controller.value.isInitialized) {
    print ("_controller.value.isInitialized=" + _controller.value.isInitialized.toString());
    if (!_controller.value.isInitialized) {
      return Scaffold(
          appBar: AppBar(title: Text('Wait...')),
          body: Center(child: CircularProgressIndicator())
      );
    }
    return Scaffold(
        appBar: AppBar(title: Text('Take a picture')),
        body: CameraPreview(_controller),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
 ///         onPressed: () => getPicture(context, _platformIsIos, _controller, widget.routDisplayPicture),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
