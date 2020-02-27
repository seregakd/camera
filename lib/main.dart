import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_camera/take_picture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/displayPicture',
      routes: {
        '/displayPicture':(context) => DisplayPicture(),
        '/takePicture':(context) => TakePictureScreen(),
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
              width: 100.0,
              height: 100.0,
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
