import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class FutureTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [darkColor, primaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight)
        ),
        child: Center(
          child: Text(
            'Todo in the future',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        )
      ),
    );
  }

}