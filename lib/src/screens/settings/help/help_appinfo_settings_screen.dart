import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class HelpAppInfoSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [darkColor, primaryColor], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WhatzApp Messenger',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Version 2.19.98',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: secondaryColor,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    '© 2010-2019 WhatzApp Inc.',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: FlatButton(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                      onPressed: (){
                        Application.router.navigateTo(
                          context,
                          Routes.licenses,
                          transition: TransitionType.inFromRight,
                        );
                      },
                      child: Text(
                        'LICENSES',
                        style: TextStyle(
                          color: Color(0xff44c6ee),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}