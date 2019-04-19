import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/home.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class FlutteredApp extends StatelessWidget {

  /// Default theme.
  static final ThemeData _defaultTheme = new ThemeData(
    primaryColor: primaryColor,
    accentColor: Colors.white,
    scaffoldBackgroundColor: scaffoldBgColor,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluttered WhatsApp',
      theme: _defaultTheme,
      home: Home(),
    );
  }

}