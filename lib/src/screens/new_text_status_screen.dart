import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';


import 'dart:math';

final _random = new Random();

// Generates a positive random integer uniformly distributed on the range
// from [min], inclusive, to [max], exclusive.
int getRandomInt(int min, int max) => min + _random.nextInt(max - min);

class NewTextStatusScreen extends StatefulWidget {
  @override
  _NewTextStatusScreenState createState() => _NewTextStatusScreenState();

}

class _NewTextStatusScreenState extends State<NewTextStatusScreen> {
  Color _bgColor;
  int _bgColorIndex;

  @override
  void initState() {
    super.initState();
    _bgColorIndex = getRandomInt(2, 4)*100;
    _bgColor = Colors.primaries[getRandomInt(0, Colors.primaries.length-1)][_bgColorIndex];
  }

  void _changeBgColor() {
    setState(() {
      _bgColorIndex = getRandomInt(2, 4)*100;
      _bgColor = Colors.primaries[getRandomInt(0, Colors.primaries.length-1)][_bgColorIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 40.0,
                    maxHeight: 240.0,
                  ),
                  child: TextField(
                    maxLines: null,
                    textAlign: TextAlign.center,
                    maxLength: 100,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                        border: InputBorder.none,
                        hintText: 'Type a status',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          fontSize: 40.0,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.insert_emoticon),
                      onPressed: (){},
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      child: Text(
                          'T',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      shape: new CircleBorder(),
                      padding: const EdgeInsets.all(18.0),
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.color_lens),
                      onPressed: (){
                        _changeBgColor();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.send),
                  onPressed: (){},
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}