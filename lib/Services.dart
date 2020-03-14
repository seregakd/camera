import 'package:flutter/material.dart';
import 'package:platform/platform.dart';

void viewShowDialog(BuildContext context, String message){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          color: Colors.lightBlueAccent,
          textColor: Colors.white,
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

bool platformIsIos() {
  return LocalPlatform().isIOS;
}
