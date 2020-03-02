import 'package:flutter/material.dart';
import 'package:my_camera/take_picture.dart';
import 'package:my_camera/display_picture.dart';

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