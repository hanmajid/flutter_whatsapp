import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/app.dart';

import 'package:camera/camera.dart';
import 'package:flutter_whatsapp/src/screens/camera_screen.dart';

//void main() {
//  runApp(FlutteredApp());
//}

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.code+'\n'+ e.description);
  }
  runApp(FlutteredApp());
}