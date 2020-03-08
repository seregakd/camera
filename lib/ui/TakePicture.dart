import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:platform/platform.dart';

class TakePicture extends StatefulWidget {
  final String routDisplayPicture;

  TakePicture({this.routDisplayPicture});

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Platform _platform = const LocalPlatform();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();

    setState(() {});
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
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),

        onPressed: () async {
          try {
            await _initializeControllerFuture;

            Directory _extDir;
            if (_platform.isIOS) {
              _extDir = await getApplicationDocumentsDirectory();
            } else {
//              _extDir = await getExternalStorageDirectory();
              _extDir = await getTemporaryDirectory();
            }
            final String dirPath = '${_extDir.path}/Pictures';
            await Directory(dirPath).create(recursive: true);
            final path = join(dirPath,'${DateTime.now()}.jpg');

            await _controller.takePicture(path);

            Navigator.pushNamedAndRemoveUntil(
              context,
              widget.routDisplayPicture,
              (Route<dynamic> route) => false,
              arguments: path,
            );

          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}