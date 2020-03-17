import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/models/status.dart';
import 'package:flutter_whatsapp/src/services/status_service.dart';


class DetailStatusScreen extends StatefulWidget {
  final int id;

  DetailStatusScreen({
    this.id,
  });

  _DetailStatusScreenState createState() => _DetailStatusScreenState();
}

class _DetailStatusScreenState extends State<DetailStatusScreen> {

  Future<Status> _fStatus;
  List<double> _width;
  int index = 0;
  int count;
  ImageProvider _image;
  List<String> imageList;

  @override
  void initState() {
    super.initState();
    _fStatus = StatusService.getStatus(widget.id).then((Status status) {
      setState(() {
        count = status.numImages;
        imageList = status.imagesUrl;
        _width = new List<double>(count);
        for(int i=0; i<count; i++) {
          _width[i] = 0.0;
        }
      });
      Future.delayed(Duration(milliseconds: 100), ()
      {
        _playStatus();
      });
      Future.delayed(Duration(seconds: status.numImages*5, milliseconds: 100), () {
        if(!mounted) return;

        Navigator.of(context).pop();
      });
      return status;
    });
  }

  _playStatus() {
    if(index < count) {
      setState(() {
        _width[index] = (MediaQuery.of(context).size.width - 4.0 - (count-1) * 4.0)/ count;
        _image = CachedNetworkImageProvider(imageList[index]);
        index++;
      });
      Future.delayed(Duration(seconds: 5), () {
        _playStatus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
                child: FutureBuilder(
            future: _fStatus,
            builder: (context, AsyncSnapshot<Status> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)),
                    );
                  }
                  if(_image == null) {
                    return Container();
                  }
                  return Image(
                      image: _image
                  );
              }
              return null; //
            }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage('https://api.adorable.io/avatars/285/circle@adorable.png'),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: _fStatus,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Container();
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      List<Widget> children = List<Widget>();
                      for(dynamic _ in snapshot.data.imagesUrl) {
                        children.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                            child: Container(
                              height: 2.5,
                              width: (mediaWidth - 4.0 - (snapshot.data.numImages-1) * 4.0)/ snapshot.data.numImages,
                              color: Color.fromRGBO(255, 255, 255, 0.4),
                            ),
                          )
                        );
                      }
                      return Row(
                        children: children,
                      );
                  }
                  return null; //
                }
            ),
            FutureBuilder(
              future: _fStatus,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    List<Widget> children = List<Widget>();
                    int i = 0;
                    for(dynamic _ in snapshot.data.imagesUrl) {
                      children.add(
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
                            child: AnimatedContainer(
                            duration: Duration(seconds: 5),
                            height: 2.5,
                            width: _width[i],
                            color: Colors.white,
                            ),
                          )
                      );
                      i++;
                    }
                    return Row(
                      children: children,
                    );
                }
                return null; //
              }
            ),
          ],
        ),
      )
    );
  }
}
