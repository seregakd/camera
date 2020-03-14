import 'package:flutter/material.dart';
import 'package:my_camera/ui/TakePicture.dart';
import 'package:my_camera/ui/DisplayPicture.dart';
import 'package:torch/torch.dart';
import 'Services.dart';
import 'ui/InitCamera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String routDisplayPicture = "displayPicture";
  final String routTakePicture = "takePicture";
  final String routInitCamera = "initCamera";

  final bool _platformIsIos = platformIsIos();
  final Future<bool> _hasTorch = Torch.hasTorch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: routDisplayPicture,

      routes: {
        routDisplayPicture:(context) => DisplayPicture(
          routInitCamera: routInitCamera
        ),
        routTakePicture:(context) => TakePicture(
          routDisplayPicture: routDisplayPicture,
          platformIsIos: _platformIsIos,
          hasTorch: _hasTorch,
        ),
        routInitCamera:(context) => InitCamera(
          routTakePicture: routTakePicture,
        ),
      },
    );
  }
}