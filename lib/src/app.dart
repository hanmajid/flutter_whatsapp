import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/home.dart';

class FlutteredApp extends StatelessWidget {

  /// WhatsApp's signature green color.
  static final primaryColor = const Color(0xff075e54);
  /// White-ish background color.
  static final scaffoldBgColor = const Color(0xfffafafa);

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