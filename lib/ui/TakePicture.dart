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
  bool _lampOn = false;

  _setLamp() {
      if (_lampOn) {
          _lampOn = false;
      } else {
          _lampOn = true;
      }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: _buildTitle(context)),
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

  Widget _buildTitle(BuildContext context) {
    return RaisedButton(
      onPressed: () => _setLamp(),
      child: Text('Torch ON/OFF'),
    );
  }

}