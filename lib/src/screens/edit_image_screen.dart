import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EditImageScreen extends StatefulWidget {
  final String id;
  final String resource;

  EditImageScreen({
    this.id,
    this.resource,
  });

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.crop_rotate),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.insert_emoticon),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SlidingUpPanel(
        minHeight: 130.0,
        maxHeight: 200.0,
        parallaxEnabled: true,
        parallaxOffset: .1,
        color: Color.fromRGBO(0, 0, 0, 0),
        boxShadow: null,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 220.0,
              child: Hero(
                tag: widget.id,
                child: Image.file(new File(widget.resource)),
              ),
            )
          ],
        ),
        collapsed: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                Text(
                  'Filters',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a caption...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      child: Icon(
                        Icons.check,
                        size: 24.0,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        panel: Container(
          height: 50.0,
          child: Opacity(
              opacity: _opacity,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    //color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    color: Color.fromRGBO(255, 255, 255, 0.1),
                    child: ListView(
                      padding: EdgeInsets.all(2.0),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 60,
                          color: Colors.yellow,
                          margin: EdgeInsets.all(2.0),
                        ),
                        Container(
                          width: 60,
                          color: Colors.yellow,
                          margin: EdgeInsets.all(2.0),
                        ),
                        Container(
                          width: 60,
                          color: Colors.yellow,
                          margin: EdgeInsets.all(2.0),
                        ),
                        Container(
                          width: 60,
                          color: Colors.yellow,
                          margin: EdgeInsets.all(2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        onPanelSlide: (double pos) {
          setState(() {
            _opacity = pos;
          });
        },
      ),
    );
  }
}
