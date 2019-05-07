import 'package:flutter/material.dart';

class YourProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 32.0,),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: 'profile-pic',
                      child: CircleAvatar(
                        radius: 70.0,
                        backgroundImage: NetworkImage('https://via.placeholder.com/300x300'),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: FloatingActionButton(
                        mini: true,
                        child: Icon(Icons.camera_alt),
                        onPressed: (){}
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}