import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item_header.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';

enum PrivacyOptions {
  everyone,
  myContacts,
  nobody,
}

var PrivacyOptionList = [
  PrivacyOptions.everyone,
  PrivacyOptions.myContacts,
  PrivacyOptions.nobody,
];

class AccountPrivacySettingsScreen extends StatefulWidget {
  @override
  _AccountPrivacySettingsScreenState createState() => _AccountPrivacySettingsScreenState();
}

class _AccountPrivacySettingsScreenState extends State<AccountPrivacySettingsScreen> {
  bool _readReceipts = false;
  PrivacyOptions _lastSeen = PrivacyOptions.nobody;
  PrivacyOptions _profilePhoto = PrivacyOptions.myContacts;
  PrivacyOptions _about = PrivacyOptions.everyone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: ListView(
        children: <Widget>[
          SettingItemHeader(
            title: 'Who can see my personal info',
            subtitle: 'If you don\'t share your Last Seen, you won\'t be able to see other people\'s Last Seen',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          SettingItem(
            title: 'Last seen',
            subtitle: _getPrivacyText(_lastSeen),
            onTap: (){
              DialogHelpers.showRadioDialog(PrivacyOptionList, 'Last seen', _getPrivacyText, context, _lastSeen, (value) {
                setState(() {
                  _lastSeen = value;
                });
              });
            },
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          SettingItem(
            title: 'Profile photo',
            subtitle: _getPrivacyText(_profilePhoto),
            onTap: (){
              DialogHelpers.showRadioDialog(PrivacyOptionList, 'Profile photo', _getPrivacyText, context, _profilePhoto, (value) {
                setState(() {
                  _profilePhoto = value;
                });
              });
            },
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          SettingItem(
            title: 'About',
            subtitle: _getPrivacyText(_about),
            onTap: (){
              DialogHelpers.showRadioDialog(PrivacyOptionList, 'About', _getPrivacyText, context, _about, (value) {
                setState(() {
                  _about = value;
                });
              });
            },
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          SettingItem(
            title: 'Status',
            subtitle: 'No contacs selected',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.statusPrivacy,
                transition: TransitionType.inFromRight,
              );
            },
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          SwitchSettingItem(
            title: 'Read receipts',
            subtitle: 'If turned off, you won\'t send or receive Read receipts. Read receipts are always sent for group chats.',
            value: _readReceipts,
            onChanged: (bool value) {
              setState(() {
                _readReceipts = value;
              });
            },
          ),
          Divider(),
          SettingItem(
            title: 'Live location',
            subtitle: 'None',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.privacyLiveLocation,
                transition: TransitionType.inFromRight,
              );
            },
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          SettingItem(
            title: 'Blocked contacts',
            subtitle: 'None',
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.privacyBlocked,
                transition: TransitionType.inFromRight,
              );
            },
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
        ]
      ),
    );
  }

  String _getPrivacyText(PrivacyOptions option) {
    switch(option) {
      case PrivacyOptions.everyone:
        return 'Everyone';
      case PrivacyOptions.myContacts:
        return 'My contacts';
      case PrivacyOptions.nobody:
        return 'Nobody';
    }
  }
}