import 'package:flutter/material.dart';
// import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';

// List<CameraDescription> qrCameras;

class WhatsappWebScanScreen extends StatefulWidget {
  @override
  _WhatsappWebScanScreenState createState() => _WhatsappWebScanScreenState();
}

class _WhatsappWebScanScreenState extends State<WhatsappWebScanScreen>
    with SingleTickerProviderStateMixin {
  // QRReaderController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );

    animationController.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0.0, end: 260.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    // pick the first available camera
    onNewCameraSelected(0);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Animation<double> verticalPosition;

  @override
  Widget build(BuildContext context) {
    double _fontSize = 19.0;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Scan code'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Visit ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: _fontSize,
                      )),
                  TextSpan(
                      text: 'web.whatsapp.com ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: _fontSize,
                      )),
                  TextSpan(
                      text: 'on your computer and scan the QR code',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: _fontSize,
                      )),
                ])),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  child: new Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Center(
                      child: _cameraPreviewWidget(),
                    ),
                  ),
                ),
                Center(
                    child: Stack(
                  children: <Widget>[
                    CustomPaint(
                      painter: Test(),
                      child: SizedBox(
                        height: 260.0,
                        width: 260.0,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(255, 255, 255, 0.4),
                                  width: 2.0)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: verticalPosition.value,
                      child: Container(
                        width: 260.0,
                        height: 4.0,
                        color: Colors.green,
                      ),
                    )
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    // if (controller == null || !controller.value.isInitialized) {
    return const Text(
      'No camera selected',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
      ),
    );
    // } else {
    //   return new AspectRatio(
    //     aspectRatio: controller.value.aspectRatio,
    //     child: new QRReaderPreview(controller),
    //   );
    // }
  }

  void onCodeRead(dynamic value) {
    Navigator.of(context).pop();
    //showInSnackBar(value.toString());
    // ... do something
    // wait 5 seconds then start scanning again.
    //new Future.delayed(const Duration(seconds: 5), controller.startScanning);
  }

  void onNewCameraSelected(int index) async {
    // if (controller != null) {
    //   await controller.dispose();
    // }
    // controller = new QRReaderController(qrCameras[index], ResolutionPreset.low,
    //     [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // // If the controller is updated then update the UI.
    // controller.addListener(() {
    //   if (mounted) setState(() {});
    //   if (controller.value.hasError) {
    //     showInSnackBar('Camera error ${controller.value.errorDescription}');
    //   }
    // });

    // try {
    //   await controller.initialize();
    // } on QRReaderException catch (e) {
    //   print('${e.code}, ${e.description}');
    //   showInSnackBar('Error: ${e.code}\n${e.description}');
    // }

    // if (mounted) {
    //   setState(() {});
    //   controller.startScanning();
    // }
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}

class Test extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromRGBO(255, 255, 255, 0.4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double lineWidth = 50;

    Path pathLeft = Path();
    pathLeft.moveTo(-lineWidth / 2, size.height / 2);
    pathLeft.lineTo(lineWidth / 2, size.height / 2);

    Path pathRight = Path();
    pathRight.moveTo(size.width - lineWidth / 2, size.height / 2);
    pathRight.lineTo(size.width + lineWidth / 2, size.height / 2);

    Path pathTop = Path();
    pathTop.moveTo(size.width / 2, -lineWidth / 2);
    pathTop.lineTo(size.width / 2, lineWidth / 2);

    Path pathBottom = Path();
    pathBottom.moveTo(size.width / 2, size.height - lineWidth / 2);
    pathBottom.lineTo(size.width / 2, size.height + lineWidth / 2);

    canvas.drawPath(pathLeft, paint);
    canvas.drawPath(pathRight, paint);
    canvas.drawPath(pathTop, paint);
    canvas.drawPath(pathBottom, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
