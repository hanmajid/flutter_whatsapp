import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/shared_preferences_helpers.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item_header.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotificationsOptions {
  resetNotificationSettings,
}

enum NotificationToneOptions {
  defaultNotificationSound,
  none,
  birdOut,
  bug,
  circle,
  ddefault,
  discourag,
  dobe,
  dodo,
  doremi,
  ethereal,
  freaking,
  grain,
  hangoutsMessage,
  little,
  moneyFall,
  promote,
  raid,
  slightShake,
  tinnitus,
  unobstrusive,
  vivid,
  whistle,
}

var notificationToneOptionsList = [
  NotificationToneOptions.defaultNotificationSound,
  NotificationToneOptions.none,
  NotificationToneOptions.birdOut,
  NotificationToneOptions.bug,
  NotificationToneOptions.circle,
  NotificationToneOptions.ddefault,
  NotificationToneOptions.discourag,
  NotificationToneOptions.dobe,
  NotificationToneOptions.dodo,
  NotificationToneOptions.doremi,
  NotificationToneOptions.ethereal,
  NotificationToneOptions.freaking,
  NotificationToneOptions.grain,
  NotificationToneOptions.hangoutsMessage,
  NotificationToneOptions.little,
  NotificationToneOptions.moneyFall,
  NotificationToneOptions.promote,
  NotificationToneOptions.raid,
  NotificationToneOptions.slightShake,
  NotificationToneOptions.tinnitus,
  NotificationToneOptions.unobstrusive,
  NotificationToneOptions.vivid,
  NotificationToneOptions.whistle,
];

enum VibrateOptions {
  off,
  ddefault,
  short,
  long,
}

var vibrateOptionsList = [
  VibrateOptions.off,
  VibrateOptions.ddefault,
  VibrateOptions.short,
  VibrateOptions.long,
];

enum PopupNotificationOptions {
  noPopup,
  onlyScreenOn,
  onlyScreenOff,
  alwaysShowPopup,
}

var popupNotificationOptionsList = [
  PopupNotificationOptions.noPopup,
  PopupNotificationOptions.onlyScreenOn,
  PopupNotificationOptions.onlyScreenOff,
  PopupNotificationOptions.alwaysShowPopup,
];

enum LightOptions {
  none,
  white,
  red,
  yellow,
  green,
  cyan,
  blue,
  purple,
}

var lightOptionsList = [
  LightOptions.none,
  LightOptions.white,
  LightOptions.red,
  LightOptions.yellow,
  LightOptions.green,
  LightOptions.cyan,
  LightOptions.blue,
  LightOptions.purple,
];

enum RingtoneOptions {
  defaultRingtone,
  none,
  anneStellaDance,
  campusLife,
  chanson,
  chirrupyCall,
  coming,
  drops,
  funTime,
  greenery,
  hangoutsCall,
  hardDealay,
  harpBell,
  highDidi,
  iceLead,
  joyfulDolls,
  lovelyXylophone,
  neoFuturistic,
  nylonGuitar,
  relax,
  rhythm,
  sawDance,
  shivaFlute,
  springCharm,
  squareWave,
  succade,
  sunriseView,
  woodenPercussion,
  xtremeTone,
}

var ringtoneOptionsList = [
  RingtoneOptions.defaultRingtone,
  RingtoneOptions.none,
  RingtoneOptions.anneStellaDance,
  RingtoneOptions.campusLife,
  RingtoneOptions.chanson,
  RingtoneOptions.chirrupyCall,
  RingtoneOptions.coming,
  RingtoneOptions.drops,
  RingtoneOptions.funTime,
  RingtoneOptions.greenery,
  RingtoneOptions.hangoutsCall,
  RingtoneOptions.hardDealay,
  RingtoneOptions.harpBell,
  RingtoneOptions.highDidi,
  RingtoneOptions.iceLead,
  RingtoneOptions.joyfulDolls,
  RingtoneOptions.lovelyXylophone,
  RingtoneOptions.neoFuturistic,
  RingtoneOptions.nylonGuitar,
  RingtoneOptions.relax,
  RingtoneOptions.rhythm,
  RingtoneOptions.sawDance,
  RingtoneOptions.shivaFlute,
  RingtoneOptions.springCharm,
  RingtoneOptions.squareWave,
  RingtoneOptions.succade,
  RingtoneOptions.sunriseView,
  RingtoneOptions.woodenPercussion,
  RingtoneOptions.xtremeTone,
];

class NotificationsSettingsScreen extends StatefulWidget {
  @override
  _NotificationsSettingsScreenState createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  VibrateOptions defaultVibrate = VibrateOptions.off;
  PopupNotificationOptions defaultPopupNotification = PopupNotificationOptions.noPopup;
  LightOptions defaultLight = LightOptions.white;
  VibrateOptions defaultGroupVibrate = VibrateOptions.off;
  PopupNotificationOptions defaultGroupPopupNotification = PopupNotificationOptions.noPopup;
  LightOptions defaultGroupLight = LightOptions.white;
  VibrateOptions defaultCallsVibrate = VibrateOptions.off;

  Future<bool> _conversationTones;
  NotificationToneOptions _notificationToneOptions;
  Future<VibrateOptions> _vibrate;
  Future<PopupNotificationOptions> _popupNotification;
  Future<LightOptions> _light;

  NotificationToneOptions _groupNotificationToneOptions;
  Future<VibrateOptions> _groupVibrate;
  Future<PopupNotificationOptions> _groupPopupNotification;
  Future<LightOptions> _groupLight;

  Future<VibrateOptions> _callsVibrate;

  bool _highPriorityNotifications = true;
  bool _groupHighPriorityNotifications = false;




  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // initialize variables
    _conversationTones = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.conversationTones) ?? SharedPreferencesHelpers.defaultConversationTones);
    });
    _vibrate = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.vibrate) != null ? vibrateOptionsList[prefs.getInt(SharedPreferencesHelpers.vibrate)] : defaultVibrate);
    });
    _popupNotification = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.popupNotification) != null ? popupNotificationOptionsList[prefs.getInt(SharedPreferencesHelpers.popupNotification)] : defaultPopupNotification);
    });
    _light = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.light) != null ? lightOptionsList[prefs.getInt(SharedPreferencesHelpers.light)] : defaultLight);
    });

    _groupVibrate = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.groupVibrate) != null ? vibrateOptionsList[prefs.getInt(SharedPreferencesHelpers.groupVibrate)] : defaultGroupVibrate);
    });
    _groupPopupNotification = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.groupPopupNotification) != null ? popupNotificationOptionsList[prefs.getInt(SharedPreferencesHelpers.groupPopupNotification)] : defaultGroupPopupNotification);
    });
    _groupLight = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.groupLight) != null ? lightOptionsList[prefs.getInt(SharedPreferencesHelpers.groupLight)] : defaultGroupLight);
    });

    _callsVibrate = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.callsVibrate) != null ? vibrateOptionsList[prefs.getInt(SharedPreferencesHelpers.callsVibrate)] : defaultCallsVibrate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: <Widget>[
          PopupMenuButton<NotificationsOptions>(
            tooltip: 'More options',
            onSelected: _selectOption,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: NotificationsOptions.resetNotificationSettings,
                  child: Text('Reset notification settings'),
                )
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
            future: _conversationTones,
            builder: (context, snapshot) {
              var onChanged;
              bool conversationTones = SharedPreferencesHelpers.defaultConversationTones;
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
                    conversationTones = snapshot.data;
                    onChanged = (bool value) {
                      _setConversationTones(value);
                    };
                  }
              }
              return SwitchSettingItem(
                title: 'Conversation tones',
                subtitle: 'Play sounds for incoming and outgoing messages.',
                value: conversationTones,
                onChanged: onChanged,
              );
            },
          ),
          Divider(),
          SettingItemHeader(
            title: 'Messages',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          SettingItem(
            title: 'Notification tone',
            subtitle: 'Silent',
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){

            },
          ),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _vibrate, _getVibrateText, (VibrateOptions value) {
            _setVibrate(value.index);
          }),
          _buildFutureSettingItem(context, 'Popup notification', popupNotificationOptionsList, _popupNotification, _getPopupNotificationText, (PopupNotificationOptions value) {
            _setPopupNotification(value.index);
          }),
          _buildFutureSettingItem(context, 'Light', lightOptionsList, _light, _getLightText, (LightOptions value) {
            _setLight(value.index);
          }),
          SwitchSettingItem(
            title: 'Use high priority notifications',
            subtitle: 'Show previews of notifications at the top of the screen.',
            value: _highPriorityNotifications,
            onChanged: (bool value) {
              setState((){
                _highPriorityNotifications = value;
              });
            },
          ),
          Divider(),
          SettingItemHeader(
            title: 'Groups',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          SettingItem(
            title: 'Notification tone',
            subtitle: 'Silent',
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){},
          ),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _groupVibrate, _getVibrateText, (VibrateOptions value) {
            _setGroupVibrate(value.index);
          }),
          _buildFutureSettingItem(context, 'Popup notification', popupNotificationOptionsList, _groupPopupNotification, _getPopupNotificationText, (PopupNotificationOptions value) {
            _setGroupPopupNotification(value.index);
          }),
          _buildFutureSettingItem(context, 'Light', lightOptionsList, _groupLight, _getLightText, (LightOptions value) {
            _setGroupLight(value.index);
          }),
          SwitchSettingItem(
            title: 'Use high priority notifications',
            subtitle: 'Show previews of notifications at the top of the screen.',
            value: _groupHighPriorityNotifications,
            onChanged: (bool value) {
              setState((){
                _groupHighPriorityNotifications = value;
              });
            },
          ),
          Divider(),
          SettingItemHeader(
            title: 'Calls',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          SettingItem(
            title: 'Ringtone',
            subtitle: 'Silent',
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){},
          ),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _callsVibrate, _getVibrateText, (VibrateOptions value) {
            _setCallsVibrate(value.index);
          }),
          SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  _buildFutureSettingItem(BuildContext context, String title, allOptions, future, getText, onChanged) {
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
                DialogHelpers.showRadioDialog(allOptions, title, getText, context, snapshot.data, onChanged);
              };
            }
        }
        return SettingItem(
            title: title,
            subtitle: subtitle,
            onTap: onTap,
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
        );
      },
    );
  }

  _selectOption(NotificationsOptions option) {
    switch(option) {
      case NotificationsOptions.resetNotificationSettings:
        break;
    }
  }

  String _getVibrateText(VibrateOptions option) {
    switch(option) {
      case VibrateOptions.off:
        return 'Off';
      case VibrateOptions.ddefault:
        return 'Default';
      case VibrateOptions.short:
        return 'Short';
      case VibrateOptions.long:
        return 'Long';
    }
  }

  String _getPopupNotificationText(PopupNotificationOptions option) {
    switch(option) {
      case PopupNotificationOptions.noPopup:
        return 'No popup';
      case PopupNotificationOptions.onlyScreenOn:
        return 'Only when screen "on"';
      case PopupNotificationOptions.onlyScreenOff:
        return 'Only when screen "off"';
      case PopupNotificationOptions.alwaysShowPopup:
        return 'Always show popup';
    }
  }

  String _getLightText(LightOptions option) {
    switch(option) {
      case LightOptions.none:
        return 'None';
      case LightOptions.white:
        return 'White';
      case LightOptions.red:
        return 'Red';
      case LightOptions.yellow:
        return 'Yellow';
      case LightOptions.green:
        return 'Green';
      case LightOptions.cyan:
        return 'Cyan';
      case LightOptions.blue:
        return 'Blue';
      case LightOptions.purple:
        return 'Purple';
    }
  }

  _setConversationTones(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _conversationTones = prefs.setBool(SharedPreferencesHelpers.conversationTones, value).then((bool success) {
        return value;
      });
    });
  }

  _setVibrate(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _vibrate = prefs.setInt(SharedPreferencesHelpers.vibrate, value).then((bool success) {
        return vibrateOptionsList[value];
      });
    });
  }

  _setPopupNotification(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _popupNotification = prefs.setInt(SharedPreferencesHelpers.popupNotification, value).then((bool success) {
        return popupNotificationOptionsList[value];
      });
    });
  }

  _setLight(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _light = prefs.setInt(SharedPreferencesHelpers.light, value).then((bool success) {
        return lightOptionsList[value];
      });
    });
  }

  _setGroupVibrate(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _groupVibrate = prefs.setInt(SharedPreferencesHelpers.groupVibrate, value).then((bool success) {
        return vibrateOptionsList[value];
      });
    });
  }

  _setGroupPopupNotification(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _groupPopupNotification = prefs.setInt(SharedPreferencesHelpers.groupPopupNotification, value).then((bool success) {
        return popupNotificationOptionsList[value];
      });
    });
  }

  _setGroupLight(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _groupLight = prefs.setInt(SharedPreferencesHelpers.groupLight, value).then((bool success) {
        return lightOptionsList[value];
      });
    });
  }

  _setCallsVibrate(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _callsVibrate = prefs.setInt(SharedPreferencesHelpers.callsVibrate, value).then((bool success) {
        return vibrateOptionsList[value];
      });
    });
  }
}