import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

Future<void> getPicture(BuildContext context, CameraController controller,
    bool platformIsIos, String routDisplayPicture) async {
  try {
    Directory _extDir;
    if (platformIsIos) {
      _extDir = await getApplicationDocumentsDirectory();
    } else {
    //  Saving to an external directory
    //  extDir = await getExternalStorageDirectory();
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

Future<CameraController> getCameraController() async {
  final cameras = await availableCameras();

  if (cameras.length > 0) {
    return CameraController(
      _selectBackCamera(cameras),
      ResolutionPreset.max,
    );
  } else {
    print("No camera available");
    return null;
  }
}

CameraDescription _selectBackCamera([List<CameraDescription> cameras]) {
  for (CameraDescription camera in cameras) {
    if (camera.lensDirection == CameraLensDirection.back) {
      return camera;
    }
  }
  return cameras.first;
}