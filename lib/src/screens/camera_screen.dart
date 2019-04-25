import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
  int _cameraIndex = 0;
  bool isShowGallery = true;
  Future<List<String>> _images;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    _initCamera(_cameraIndex);
    _getGalleryImages();
  }

  void _getGalleryImages() {
    setState(() {
      _images = getExternalStorageDirectory().then((dir) {
        List<String> paths = new List<String>();
        Directory dir2 = new Directory(dir.path + '/DCIM/Camera');
        // execute an action on each entry
        dir2.listSync(recursive: false).forEach((f) {
          if (f.path.contains('.jpg')) {
            paths.add(f.path);
          }
        });
        return paths.reversed.toList().sublist(0,10);
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  _initCamera(int index) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameras[index], ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            isShowGallery = false;
          });
        },
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[Expanded(child: _cameraPreviewWidget())],
          ),
          Positioned(
              bottom: 10.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isShowGallery
                      ? Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                        )
                      : Container(),
                  isShowGallery
                      ? Container(
                          height: 80.0,
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder<List<String>>(
                              future: _images,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.grey),
                                      ),
                                    );
                                  case ConnectionState.active:
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.grey),
                                      ),
                                    );
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    }
                                    if(snapshot.data.length <= 0) return Container();
                                    return ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      itemCount: snapshot.data.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        print(snapshot.data[i]);
                                        return GalleryItemThumbnail(
                                            resource: snapshot.data[i],
                                          onTap: () {
                                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(snapshot.data[i])));
                                          },
                                        );
                                      },
                                    );
                                }
                                return null;
                              }),
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.flash_off),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.panorama_fish_eye),
                          iconSize: 70.0,
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.switch_camera),
                          color: Colors.white,
                          highlightColor: Colors.green,
                          splashColor: Colors.red,
                          onPressed: _toggleCamera,
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
                      ))
                ],
              ))
        ]),
      ),
    );
  }

  void _toggleCamera() {
    setState(() {
      if (_cameraIndex == 0)
        _cameraIndex = 1;
      else
        _cameraIndex = 0;
    });
    _initCamera(_cameraIndex);
  }
}

class GalleryItemThumbnail extends StatelessWidget {

  GalleryItemThumbnail({
    this.resource,
    this.onTap,
  });

  final String resource;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      color: Color.fromRGBO(255, 255, 255, 0.05),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.file(
              new File(resource),
              width: 81,
              height: 81,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
