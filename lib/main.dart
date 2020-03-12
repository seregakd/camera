import 'package:flutter/material.dart';
import 'package:my_camera/ui/TakePicture2.dart';
import 'package:my_camera/ui/DisplayPicture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String routDisplayPicture = "displayPicture";
  final String routTakePicture = "takePicture";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: routDisplayPicture,
      routes: {
        routDisplayPicture:(context) => DisplayPicture(routTakePicture: routTakePicture),
        routTakePicture:(context) => TakePicture2(routDisplayPicture: routDisplayPicture),
      },
    );
  }
}