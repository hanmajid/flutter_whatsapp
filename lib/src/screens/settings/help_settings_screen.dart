import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';

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
            onTap: (){},
          ),
          SettingItem(
            icon: Icons.group,
            title: 'Contact us',
            subtitle: 'Questions? Need help?',
            onTap: () {
              Application.router.navigateTo(
                context,
                Routes.helpContactSettings,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.insert_drive_file,
            title: 'Terms and Privacy Policy',
            onTap: () {

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

}