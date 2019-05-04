import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        children: <Widget>[
          SettingItem(
            icon: Icons.lock,
            title: 'Privacy',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.accountPrivacySettings,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.security,
            title: 'Security',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.accountSecuritySettings,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.verified_user,
            title: 'Two-step verification',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.accountTwoStepSettings,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.phonelink_setup,
            title: 'Change number',
            onTap: (){
              Application.router.navigateTo(
                context,
                //Routes.accountChangeNumSettings,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.insert_drive_file,
            title: 'Request account info',
            onTap: (){
              Application.router.navigateTo(
                context,
                //Routes.accountRequestSettings,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.delete,
            title: 'Delete my account',
            onTap: (){
              Application.router.navigateTo(
                context,
                //Routes.accountDeleteSettings,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
        ],
      ),
    );
  }

}