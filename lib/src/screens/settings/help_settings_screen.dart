import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: ListView(
        children: <Widget>[
          SettingItem(
            icon: Icons.help_outline,
            title: 'FAQ',
            onTap: (){
              String url = 'https://faq.whatsapp.com/';
              _launchURL(url);
              },
          ),
          SettingItem(
            icon: Icons.group,
            title: 'Contact us',
            subtitle: 'Questions? Need help?',
            onTap: () {
              Application.router.navigateTo(
                context,
                //Routes.helpContactSettings,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.insert_drive_file,
            title: 'Terms and Privacy Policy',
            onTap: () {
              String url = 'https://whatsapp.com/legal';
              _launchURL(url);
            }
          ),
          SettingItem(
            icon: Icons.info_outline,
            title: 'App info',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.helpAppInfoSettings,
                transition: TransitionType.inFromRight,
              );
            },
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
