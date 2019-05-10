import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraHome();
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
  PanelController _panelController;
  String videoPath;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    _initCamera(_cameraIndex);
    _getGalleryImages();
    _panelController = new PanelController();
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
        return paths.reversed.toList().sublist(0, 10);
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _disposeCamera();
    super.dispose();
  }

  _disposeCamera() async {
    if (controller != null) {
      await controller.dispose();
    }
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
            _minHeight = 0;
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

  double _opacity = 0.0;
  double _minHeight = 210.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            SlidingUpPanel(
              controller: _panelController,
              maxHeight: MediaQuery.of(context).size.height,
              minHeight: _minHeight,
              panel: Opacity(
                opacity: _opacity,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      color: secondaryColor,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _panelController.close();
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        color: secondaryColor,
                        icon: Icon(Icons.check_box),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  body: Container(
                    color: Colors.white,
                    child: FutureBuilder<List<String>>(
                        future: _images,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                              );
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.grey),
                                ),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }
                              if (snapshot.data.length <= 0) return Container();
                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverPersistentHeader(
                                    pinned: true,
                                    floating: false,
                                    delegate:
                                        _SliverAppBarDelegate(text: 'RECENTLY'),
                                  ),
                                  SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 2.0,
                                      crossAxisSpacing: 2.0,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        return GalleryItemThumbnail(
                                          heroId: 'itemPanel-$index',
                                          height: 150,
                                          resource: snapshot.data[index],
                                          onTap: () {
                                            Application.router.navigateTo(
                                              context,
                                              "/edit/image?resource=${Uri.encodeComponent(snapshot.data[index])}&id=itemPanel-$index",
                                              transition: TransitionType.fadeIn,
                                            );
                                          },
                                        );
                                      },
                                      childCount: snapshot.data.length,
                                    ),
                                  )
                                ],
                              );
                          }
                          return null;
                        }),
                  ),
                ),
              ),
              color: Color.fromARGB(0, 0, 0, 0),
              collapsed: isShowGallery ? _buildCollapsedPanel() : Container(),
              body: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        controller != null && controller.value.isRecordingVideo
                            ? Colors.red
                            : Colors.black,
                    width: 2.0,
                  ),
                  color: Colors.black,
                ),
                child: _cameraPreviewWidget(),
              ),
              onPanelSlide: (double pos) {
                setState(() {
                  _opacity = pos;
                });
              },
            ),
            Positioned(
              bottom: 2.0,
              child: Opacity(
                  opacity: 1 - _opacity,
                  child: Column(
                    children: <Widget>[
                      _buildCameraControls(),
                      Container(
                          child: Text(
                        'Hold for video, tap for photo',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )),
            )
          ],
        ),
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

  Widget _buildCollapsedPanel() {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
          _buildGalleryItems(),
        ],
      ),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!controller.value.isInitialized) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error: camera is not initialized')));
    }
//    final Directory extDir = await getApplicationDocumentsDirectory();
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/DCIM/Camera';
    //await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpeg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.description}')));
    }
    return filePath;
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error: camera is not initialized')));
      return null;
    }

    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/DCIM/Camera';
    //await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.description}')));
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.description}')));
      return null;
    }

    // await _startVideoPlayer();
  }

  void onTakePictureButtonPressed() {
    _takePicture().then((String filePath) {
      if (mounted) {
        setState(() {});
        if (filePath != null) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Picture saved to $filePath')));
        }
      }
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) {
        setState(() {});
      }
      if (filePath != null) {
//        Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text('Saving video to $filePath'))
//        );
      }
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) {
        setState(() {});
      }
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Video recorded to $videoPath')));
    });
  }

  Widget _buildCameraControls() {
    return Container(
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
          GestureDetector(
            child: Icon(
              Icons.panorama_fish_eye,
              size: 70.0,
              color: Colors.white,
            ),
            onTap: () {
              if (controller == null ||
                  !controller.value.isInitialized ||
                  controller.value.isRecordingVideo) return;
              onTakePictureButtonPressed();
            },
            onLongPress: () {
              if (controller == null ||
                  !controller.value.isInitialized ||
                  controller.value.isRecordingVideo) return;
              onVideoRecordButtonPressed();
            },
            onLongPressUp: () {
              if (controller == null ||
                  !controller.value.isInitialized ||
                  !controller.value.isRecordingVideo) return;
              onStopButtonPressed();
            },
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
    );
  }

  Widget _buildGalleryItems() {
    return Container(
      height: 80.0,
      child: FutureBuilder<List<String>>(
          future: _images,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.data.length <= 0) return Container();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    //print(snapshot.data[i]);
                    return GalleryItemThumbnail(
                      heroId: 'item-$i',
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      height: 81,
                      resource: snapshot.data[i],
                      onTap: () {
                        Application.router.navigateTo(
                          context,
                          "/edit/image?resource=${Uri.encodeComponent(snapshot.data[i])}&id=item-$i",
                          transition: TransitionType.fadeIn,
                        );
                      },
                    );
                  },
                );
            }
            return null;
          }),
    );
  }
}

class GalleryItemThumbnail extends StatelessWidget {
  GalleryItemThumbnail({
    this.heroId,
    this.resource,
    this.onTap,
    this.height,
    this.margin,
  });

  final String heroId;
  final double height;
  final String resource;
  final GestureTapCallback onTap;
  final margin;

  @override
  Widget build(BuildContext context) {
    //print('gallery: img-$id');
    return Container(
      margin: margin,
      color: Color.fromRGBO(255, 255, 255, 0.05),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: heroId,
              child: Image.file(
                new File(resource),
                width: height,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.text,
  });

  final String text;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.bold),
        ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => 46.0;

  @override
  double get minExtent => 46.0;
}
