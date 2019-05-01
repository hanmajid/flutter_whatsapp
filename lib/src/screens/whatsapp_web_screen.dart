import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class WhatsappWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatzapp Web'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Scan QR code',
            onPressed: (){
              Application.router.navigateTo(
                context,
                Routes.whatsappWebScan,
                transition: TransitionType.inFromRight,
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 16.0),
                  child: Text(
                    'Logged in devices',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: Icon(Icons.laptop_mac),
                  title: Text(
                    'Last active today at 18:05'
                  ),
                  subtitle: Text(
                    'Windows 10',
                  ),
                  onTap: (){
                    Application.router.navigateTo(
                      context,
                      Routes.logoutDevice,
                      transition: TransitionType.inFromRight,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(
                    height: 0.0,
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                      'Log out from all devices',
                    style: TextStyle(
                      color: blueCheckColor,
                    ),
                  ),
                  onTap: (){
                    Application.router.navigateTo(
                      context,
                      Routes.logoutAllDevices,
                      transition: TransitionType.inFromRight,
                    );
                  },
                ),
                SizedBox(
                  height: 4.0,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Scan any QR code on your computer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
          )
        ]
      ),
    );
  }

}