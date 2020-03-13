import 'package:flutter/material.dart';
import 'package:my_camera/ui/TakePicture.dart';
import 'package:my_camera/ui/DisplayPicture.dart';
import 'Services.dart';
import 'InitCamera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String routDisplayPicture = "displayPicture";
  final String routTakePicture = "takePicture";
  final String routInitCamera = "initCamera";

  final bool _platformIsIos = platformIsIos();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: routDisplayPicture,
      routes: {
        routDisplayPicture:(context) => DisplayPicture(routCameraService: routInitCamera),
        routTakePicture:(context) => TakePicture(
          routDisplayPicture: routDisplayPicture,
          platformIsIos: _platformIsIos
        ),
        routInitCamera:(context) => InitCamera(routTakePicture: routTakePicture),
      },
    );
  }
}