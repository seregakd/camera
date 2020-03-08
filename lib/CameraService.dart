import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:platform/platform.dart';

Future<void> getPicture(BuildContext context) async {
  try {
    Directory _extDir;
    if (_platform.isIOS) {
      _extDir = await getApplicationDocumentsDirectory();
    } else {
//              _extDir = await getExternalStorageDirectory();
      _extDir = await getTemporaryDirectory();
    }
    final String dirPath = '${_extDir.path}/Pictures';
    await Directory(dirPath).create(recursive: true);
    final path = join(dirPath,'${DateTime.now()}.jpg');

    await _controller.takePicture(path);

    Navigator.pushNamedAndRemoveUntil(
      context,
      widget.routDisplayPicture,
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