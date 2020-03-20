import 'dart:io';

import 'package:flutter/material.dart';

class CorrectPicture extends StatefulWidget {
  final String routDisplayPicture;

  CorrectPicture({this.routDisplayPicture});

  @override
  CorrectPictureState createState() => CorrectPictureState();
}

class CorrectPictureState extends State<CorrectPicture> with TickerProviderStateMixin{
  AnimationController _controller;
  CurvedAnimation _curve;
/*
  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 3,
  );
*/
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final String picturePath = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Correct picture")),
//      body: Center(
//        child: Image.file(File(picturePath)),
//      ),
      body: Center(
        child: GestureDetector(
          child: RotationTransition(
            turns: _curve,
            child: Center(
              child: Image.file(File(picturePath)),
            ),
          ),
          onDoubleTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          widget.routDisplayPicture,
          (Route<dynamic> route) => false,
          arguments: picturePath,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

/*
      AspectRatio(
        aspectRatio: 487 / 451,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: FileImage(File(picturePath)),
              ),
            )),
      );
 */