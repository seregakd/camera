import 'dart:async';

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
      initialRoute: '/',
      routes: {
        '/':(context) => DisplayImage(),
        '/takePicture':(context) => TakePictureScreen(camera: camera),
      },
    );
  }
}

class DisplayImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Display the picture')),
        body: Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.pushNamed(context,'/takePicture');
            },
        )
    );
  }
}
