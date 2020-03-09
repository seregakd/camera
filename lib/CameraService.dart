import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:platform/platform.dart';

Future<void> getPicture(BuildContext context, bool platformIsIos,
    CameraController controller, String routDisplayPicture) async {
  try {
    Directory _extDir;
    if (platformIsIos) {
      _extDir = await getApplicationDocumentsDirectory();
    } else {
//              _extDir = await getExternalStorageDirectory();
      _extDir = await getTemporaryDirectory();
    }
    final String dirPath = '${_extDir.path}/Pictures';
    await Directory(dirPath).create(recursive: true);
    final path = join(dirPath,'${DateTime.now()}.jpg');

    await controller.takePicture(path);

    Navigator.pushNamedAndRemoveUntil(
      context,
      routDisplayPicture,
          (Route<dynamic> route) => false,
      arguments: path,
    );

  } catch (e) {
    print(e);
  }
}

bool platformIsIos() {
  return LocalPlatform().isIOS;
}