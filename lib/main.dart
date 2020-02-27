import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_camera/take_picture.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  MyApp(this.camera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/displayPicture',
      routes: {
        '/displayPicture':(context) => DisplayPicture(),
        '/takePicture':(context) => TakePictureScreen(camera: camera),
      },
    );
  }
}

class DisplayPicture extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    if (picturePath != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Display the picture')),
        body: Center(
          child: Image.file(File(picturePath)),
        ),
        floatingActionButton: FloatingActionButton(
          child:
          Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.pushNamed(context, '/takePicture');
          },
        )
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Take a picture')),
        floatingActionButton:
          Center(
            child: SizedBox(
              width: 80.0,
              height: 80.0,
              child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.pushNamed(context, '/takePicture');
                },
              )
            ),
          ),
      );
    }
  }
}
