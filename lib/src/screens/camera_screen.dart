import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraHome(),
    );
  }
}

class CameraHome extends StatefulWidget {
  @override
  _CameraHomeState createState() => _CameraHomeState();
}

class _CameraHomeState extends State<CameraHome> {
  CameraController controller;

  @override
  void initState() {
    super.initState();

    _initCamera();
  }

  _initCamera() async {
    if(controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameras[0], ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if(mounted) setState(() {});
      if(controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch(e) {
      print(e);
    }

    if(mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: Text(
          'Camera',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(
                    child: _cameraPreviewWidget()
                  )
                ],
              ),
              Positioned(
                bottom: 10.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.flash_off),
                                color: Colors.white,
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Icon(Icons.panorama_fish_eye),
                                iconSize: 70.0,
                                color: Colors.white,
                                onPressed: (){},
                              ),
                              IconButton(
                                icon: Icon(Icons.switch_camera),
                                color: Colors.white,
                                onPressed: (){},
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Hold for video, tap for photo',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                        )
                      ],
                    )
                  ],
                ),
              )
            ]
          ),
      ),
    );
  }

}