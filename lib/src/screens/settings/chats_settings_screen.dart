import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';
import 'package:flutter_whatsapp/src/config/shared_preferences_helpers.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FontSizeOptions {
  small,
  medium,
  large,
}

var fontSizeOptionsList = [
  FontSizeOptions.small,
  FontSizeOptions.medium,
  FontSizeOptions.large,
];

class ChatsSettingsScreen extends StatefulWidget {
  @override
  _ChatsSettingsScreenState createState() => _ChatsSettingsScreenState();
}

class _ChatsSettingsScreenState extends State<ChatsSettingsScreen> {
  FontSizeOptions defaultFontSize = FontSizeOptions.medium;

  Future<bool> _enterIsSend;
  Future<bool> _mediaVisibility;
  Future<FontSizeOptions> _fontSize;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // initialize variables
    _enterIsSend = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.enterIsSend) ?? SharedPreferencesHelpers.defaultEnterIsSend);
    });
    _mediaVisibility = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.mediaVisibility) ?? SharedPreferencesHelpers.defaultMediaVisibility);
    });
    _fontSize = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.fontSize) != null ? fontSizeOptionsList[prefs.getInt(SharedPreferencesHelpers.fontSize)] : defaultFontSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: _enterIsSend,
            builder: (context, snapshot) {
              var onChanged;
              bool enterIsSend = SharedPreferencesHelpers.defaultEnterIsSend;
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
                    enterIsSend = snapshot.data;
                    onChanged = (bool value) {
                      _setEnterIsSend(value);
                    };
                  }
              }
              return  SwitchSettingItem(
                title: 'Enter is send',
                subtitle: 'Enter key will send your message',
                onChanged: onChanged,
                value: enterIsSend,
                padding: EdgeInsets.only(right: 16.0, left: 70.0, top: 12.0, bottom: 12.0),
              );
            },
          ),
          FutureBuilder(
            future: _mediaVisibility,
            builder: (context, snapshot) {
              var onChanged;
              bool mediaVisibility = SharedPreferencesHelpers.defaultMediaVisibility;
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
                    mediaVisibility = snapshot.data;
                    onChanged = (bool value) {
                      _setMediaVisibility(value);
                    };
                  }
              }
              return SwitchSettingItem(
                title: 'Media visibility',
                subtitle: 'Show newly downloaded media in your phone\'s gallery',
                onChanged: onChanged,
                value: mediaVisibility,
                padding: EdgeInsets.only(right: 16.0, left: 70.0, top: 12.0, bottom: 12.0),
              );
            },
          ),
          FutureBuilder(
            future: _fontSize,
            builder: (context, snapshot) {
              String fontSize = '-';
              var onTap;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  fontSize = '-';
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    fontSize = 'Error: ${snapshot.error}';
                    print(snapshot.error);
                  }
                  else {
                    fontSize = _getFontSizeText(snapshot.data);
                    onTap = (){
                      DialogHelpers.showRadioDialog(fontSizeOptionsList, 'Font size', _getFontSizeText, context, snapshot.data, false, (FontSizeOptions value) {
                        _setFontSize(value.index);
                      });
                    };
                  }
              }
              return SettingItem(
                  title: 'Font size',
                  subtitle: fontSize,
                  onTap: onTap,
                padding: EdgeInsets.only(right: 16.0, left: 70.0,),
              );
            },
          ),
          Divider(),
          SettingItem(
            icon: Icons.wallpaper,
            title: 'Wallpaper',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            onTap: (){},
          ),
          SettingItem(
            icon: Icons.cloud_upload,
            title: 'Chat backup',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          SettingItem(
            icon: Icons.history,
            title: 'Chat history',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.futureTodo,
                transition: TransitionType.inFromRight,
              );
            },
          ),
        ],
      ),
    );
  }

  String _getFontSizeText(FontSizeOptions option) {
    switch(option) {
      case FontSizeOptions.small:
        return 'Small';
      case FontSizeOptions.medium:
        return 'Medium';
      case FontSizeOptions.large:
        return 'Large';
    }
    return ''; // unreachable
  }

  _setEnterIsSend(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _enterIsSend = prefs.setBool(SharedPreferencesHelpers.enterIsSend, value).then((bool success) {
        return value;
      });
    });
  }

  _setMediaVisibility(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _mediaVisibility = prefs.setBool(SharedPreferencesHelpers.mediaVisibility, value).then((bool success) {
        return value;
      });
    });
  }

  _setFontSize(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _fontSize = prefs.setInt(SharedPreferencesHelpers.fontSize, value).then((bool success) {
        return fontSizeOptionsList[value];
      });
    });
  }
}