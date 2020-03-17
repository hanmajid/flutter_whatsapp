import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/config/shared_preferences_helpers.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item_header.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrivacyOptions {
  everyone,
  myContacts,
  nobody,
}

var privacyOptionList = [
  PrivacyOptions.everyone,
  PrivacyOptions.myContacts,
  PrivacyOptions.nobody,
];

class AccountPrivacySettingsScreen extends StatefulWidget {
  @override
  _AccountPrivacySettingsScreenState createState() => _AccountPrivacySettingsScreenState();
}

class _AccountPrivacySettingsScreenState extends State<AccountPrivacySettingsScreen> {

  PrivacyOptions defaultLastSeen = PrivacyOptions.nobody;
  PrivacyOptions defaultProfilePhoto = PrivacyOptions.myContacts;
  PrivacyOptions defaultAbout = PrivacyOptions.everyone;
  bool defaultReadReceipts = false;

  Future<PrivacyOptions> _lastSeen;
  Future<PrivacyOptions> _profilePhoto;
  Future<PrivacyOptions> _about;
  Future<bool> _readReceipts;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // initialize variables
    _lastSeen = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.lastSeen) != null ? privacyOptionList[prefs.getInt(SharedPreferencesHelpers.lastSeen)] : defaultLastSeen);
    });
    _profilePhoto = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.profilePhoto) != null ? privacyOptionList[prefs.getInt(SharedPreferencesHelpers.profilePhoto)] : defaultProfilePhoto);
    });
    _about = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.about) != null ? privacyOptionList[prefs.getInt(SharedPreferencesHelpers.about)] : defaultAbout);
    });
    _readReceipts = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.readReceipts) ?? defaultReadReceipts);
    });
  }

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
          _buildFutureSettingItem(context, 'Last seen', _lastSeen, _getPrivacyText, (PrivacyOptions value) {
            _setLastSeen(value.index);
          }),
          _buildFutureSettingItem(context, 'Profile photo', _profilePhoto, _getPrivacyText, (PrivacyOptions value) {
            _setProfilePhoto(value.index);
          }),
          _buildFutureSettingItem(context, 'About', _about, _getPrivacyText, (PrivacyOptions value) {
            _setAbout(value.index);
          }),
          SettingItem(
            title: 'Status',
            subtitle: 'No contacts selected',
            onTap: (){
              Application.router.navigateTo(
                context,
                //Routes.statusPrivacy,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
          ),
          FutureBuilder(
            future: _readReceipts,
            builder: (context, snapshot) {
              var onChanged;
              bool readReceipts = false;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  else {
                    readReceipts = snapshot.data;
                    onChanged = (bool value) {
                      _setReadReceipts(value);
                    };
                  }
              }
              return SwitchSettingItem(
                title: 'Read receipts',
                subtitle: 'If turned off, you won\'t send or receive Read receipts. Read receipts are always sent for group chats.',
                value: readReceipts,
                onChanged: onChanged,
              );
            },
          ),
          Divider(),
          SettingItem(
            title: 'Live location',
            subtitle: 'None',
            onTap: (){
              Application.router.navigateTo(
                context,
                //Routes.privacyLiveLocation,
                Routes.futureTodo,
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
                //Routes.privacyBlocked,
                Routes.futureTodo,
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
      default:
        return '';
    }
  }

  _buildFutureSettingItem(BuildContext context, String title, future, getText, onChanged) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        String subtitle = '-';
        var onTap;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            subtitle = '-';
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              subtitle = 'Error: ${snapshot.error}';
              print(snapshot.error);
            }
            else {
              subtitle = getText(snapshot.data);
              onTap = (){
                DialogHelpers.showRadioDialog(privacyOptionList, title, getText, context, snapshot.data, false, onChanged);
              };
            }
        }
        return SettingItem(
            title: title,
            subtitle: subtitle,
            onTap: onTap,
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0)
        );
      },
    );
  }

  _setLastSeen(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _lastSeen = prefs.setInt(SharedPreferencesHelpers.lastSeen, value).then((bool success) {
        return privacyOptionList[value];
      });
    });
  }

  _setProfilePhoto(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _profilePhoto = prefs.setInt(SharedPreferencesHelpers.profilePhoto, value).then((bool success) {
        return privacyOptionList[value];
      });
    });
  }

  _setAbout(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _about = prefs.setInt(SharedPreferencesHelpers.about, value).then((bool success) {
        return privacyOptionList[value];
      });
    });
  }

  _setReadReceipts(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _readReceipts = prefs.setBool(SharedPreferencesHelpers.readReceipts, value).then((bool success) {
        return value;
      });
    });
  }


}