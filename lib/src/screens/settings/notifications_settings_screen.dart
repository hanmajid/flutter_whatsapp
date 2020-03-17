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
  NotificationToneOptions defaultNotificationTone;
  VibrateOptions defaultVibrate = VibrateOptions.off;
  PopupNotificationOptions defaultPopupNotification = PopupNotificationOptions.noPopup;
  LightOptions defaultLight = LightOptions.white;

  NotificationToneOptions defaultGroupNotificationTone;
  VibrateOptions defaultGroupVibrate = VibrateOptions.off;
  PopupNotificationOptions defaultGroupPopupNotification = PopupNotificationOptions.noPopup;
  LightOptions defaultGroupLight = LightOptions.white;

  RingtoneOptions defaultCallsRingtone;
  VibrateOptions defaultCallsVibrate = VibrateOptions.off;

  Future<bool> _conversationTones;
  Future<NotificationToneOptions> _notificationTone;
  Future<VibrateOptions> _vibrate;
  Future<PopupNotificationOptions> _popupNotification;
  Future<LightOptions> _light;
  Future<bool> _useHighPriorityNotifications;

  Future<NotificationToneOptions> _groupNotificationTone;
  Future<VibrateOptions> _groupVibrate;
  Future<PopupNotificationOptions> _groupPopupNotification;
  Future<LightOptions> _groupLight;
  Future<bool> _groupUseHighPriorityNotifications;

  Future<RingtoneOptions> _callsRingtone;
  Future<VibrateOptions> _callsVibrate;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // initialize variables
    _conversationTones = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.conversationTones) ?? SharedPreferencesHelpers.defaultConversationTones);
    });
    _notificationTone = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.notificationTone) != null ? notificationToneOptionsList[prefs.getInt(SharedPreferencesHelpers.notificationTone)] : defaultNotificationTone);
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
    _useHighPriorityNotifications = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.useHighPriorityNotifications) ?? SharedPreferencesHelpers.defaultUseHighPriorityNotifications);
    });

    _groupNotificationTone = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.groupNotificationTone) != null ? notificationToneOptionsList[prefs.getInt(SharedPreferencesHelpers.groupNotificationTone)] : defaultGroupNotificationTone);
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
    _groupUseHighPriorityNotifications = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.groupUseHighPriorityNotifications) ?? SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications);
    });

    _callsRingtone = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt(SharedPreferencesHelpers.callsRingtone) != null ? ringtoneOptionsList[prefs.getInt(SharedPreferencesHelpers.callsRingtone)] : defaultCallsRingtone);
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
          _buildFutureSettingItem(context, 'Notification tone', notificationToneOptionsList, _notificationTone, _getNotificationToneText, true, (NotificationToneOptions value) {
            _setNotificationTone(value.index);
          }),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _vibrate, _getVibrateText, false, (VibrateOptions value) {
            _setVibrate(value.index);
          }),
          _buildFutureSettingItem(context, 'Popup notification', popupNotificationOptionsList, _popupNotification, _getPopupNotificationText, false, (PopupNotificationOptions value) {
            _setPopupNotification(value.index);
          }),
          _buildFutureSettingItem(context, 'Light', lightOptionsList, _light, _getLightText, false, (LightOptions value) {
            _setLight(value.index);
          }),
          FutureBuilder(
            future: _useHighPriorityNotifications,
            builder: (context, snapshot) {
              var onChanged;
              bool useHighPriorityNotifications = SharedPreferencesHelpers.defaultUseHighPriorityNotifications;
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
                    useHighPriorityNotifications = snapshot.data;
                    onChanged = (bool value) {
                      _setUseHighPriorityNotifications(value);
                    };
                  }
              }
              return SwitchSettingItem(
                title: 'Use high priority notifications',
                subtitle: 'Show previews of notifications at the top of the screen.',
                value: useHighPriorityNotifications,
                onChanged: onChanged,
              );
            },
          ),
          Divider(),
          SettingItemHeader(
            title: 'Groups',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          _buildFutureSettingItem(context, 'Notification tone', notificationToneOptionsList, _groupNotificationTone, _getNotificationToneText, true, (NotificationToneOptions value) {
            _setGroupNotificationTone(value.index);
          }),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _groupVibrate, _getVibrateText, false, (VibrateOptions value) {
            _setGroupVibrate(value.index);
          }),
          _buildFutureSettingItem(context, 'Popup notification', popupNotificationOptionsList, _groupPopupNotification, _getPopupNotificationText, false, (PopupNotificationOptions value) {
            _setGroupPopupNotification(value.index);
          }),
          _buildFutureSettingItem(context, 'Light', lightOptionsList, _groupLight, _getLightText, false, (LightOptions value) {
            _setGroupLight(value.index);
          }),
          FutureBuilder(
            future: _groupUseHighPriorityNotifications,
            builder: (context, snapshot) {
              var onChanged;
              bool groupUseHighPriorityNotifications = SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications;
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
                    groupUseHighPriorityNotifications = snapshot.data;
                    onChanged = (bool value) {
                      _setGroupUseHighPriorityNotifications(value);
                    };
                  }
              }
              return SwitchSettingItem(
                title: 'Use high priority notifications',
                subtitle: 'Show previews of notifications at the top of the screen.',
                value: groupUseHighPriorityNotifications,
                onChanged: onChanged,
              );
            },
          ),
          Divider(),
          SettingItemHeader(
            title: 'Calls',
            padding: EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 4.0),
          ),
          _buildFutureSettingItem(context, 'Ringtone', ringtoneOptionsList, _callsRingtone, _getRingtoneText, true, (RingtoneOptions value) {
            _setCallsRingtone(value.index);
          }),
          _buildFutureSettingItem(context, 'Vibrate', vibrateOptionsList, _callsVibrate, _getVibrateText, false, (VibrateOptions value) {
            _setCallsVibrate(value.index);
          }),
          SizedBox(
            height: 8.0,
          )
        ],
      ),
    );
  }

  _buildFutureSettingItem(BuildContext context, String title, allOptions, future, getText, bool isActions, onChanged) {
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
                DialogHelpers.showRadioDialog(allOptions, title, getText, context, snapshot.data, isActions, onChanged);
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
        _resetSettings();
        break;
    }
  }

  String _getNotificationToneText(NotificationToneOptions option) {
    switch(option) {
      case NotificationToneOptions.defaultNotificationSound:
        return 'Default notification sound';
      case NotificationToneOptions.none:
        return 'None';
      case NotificationToneOptions.birdOut:
        return 'Bird Out';
      case NotificationToneOptions.bug:
        return 'Bug';
      case NotificationToneOptions.circle:
        return 'Circle';
      case NotificationToneOptions.ddefault:
        return 'Default';
      case NotificationToneOptions.discourag:
        return 'Discourag';
      case NotificationToneOptions.dobe:
        return 'Dobe';
      case NotificationToneOptions.dodo:
        return 'Dodo';
      case NotificationToneOptions.doremi:
        return 'DoReMi';
      case NotificationToneOptions.ethereal:
        return 'Ethereal';
      case NotificationToneOptions.freaking:
        return 'Freaking';
      case NotificationToneOptions.grain:
        return 'Grain';
      case NotificationToneOptions.hangoutsMessage:
        return 'Hangouts Message';
      case NotificationToneOptions.little:
        return 'Little';
      case NotificationToneOptions.moneyFall:
        return 'Money Fall';
      case NotificationToneOptions.promote:
        return 'Promote';
      case NotificationToneOptions.raid:
        return 'Raid';
      case NotificationToneOptions.slightShake:
        return 'Slight Shake';
      case NotificationToneOptions.tinnitus:
        return 'Tinnitus';
      case NotificationToneOptions.unobstrusive:
        return 'Unobstrusive';
      case NotificationToneOptions.vivid:
        return 'Vivid';
      case NotificationToneOptions.whistle:
        return 'Whistle';
      default:
        return 'Silent';
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
    return ''; // unreachable
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
    return ''; // unreachable
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
    return ''; // unreachable
  }

  String _getRingtoneText(RingtoneOptions option) {
    switch(option) {
      case RingtoneOptions.defaultRingtone:
        return 'Default ringtone';
      case RingtoneOptions.none:
        return 'None';
      case RingtoneOptions.anneStellaDance:
        return 'Anne Stella Dance';
      case RingtoneOptions.campusLife:
        return 'Campus Life';
      case RingtoneOptions.chanson:
        return 'Chanson';
      case RingtoneOptions.chirrupyCall:
        return 'Chirrupy Call';
      case RingtoneOptions.coming:
        return 'Coming';
      case RingtoneOptions.drops:
        return 'Drops';
      case RingtoneOptions.funTime:
        return 'Fun Time';
      case RingtoneOptions.greenery:
        return 'Greenery';
      case RingtoneOptions.hangoutsCall:
        return 'Hangouts Call';
      case RingtoneOptions.hardDealay:
        return 'Hard Dealay';
      case RingtoneOptions.harpBell:
        return 'Harp Bell';
      case RingtoneOptions.highDidi:
        return 'High Didi';
      case RingtoneOptions.iceLead:
        return 'Ice Lead';
      case RingtoneOptions.joyfulDolls:
        return 'Joufyl Dolls';
      case RingtoneOptions.lovelyXylophone:
        return 'Lovely Xylophone';
      case RingtoneOptions.neoFuturistic:
        return 'Neo Futuristic';
      case RingtoneOptions.nylonGuitar:
        return 'Nylon Guitar';
      case RingtoneOptions.relax:
        return 'Relax';
      case RingtoneOptions.rhythm:
        return 'Rhythm';
      case RingtoneOptions.sawDance:
        return 'Saw Dance';
      case RingtoneOptions.shivaFlute:
        return 'Shiva Flute';
      case RingtoneOptions.springCharm:
        return 'Spring Charm';
      case RingtoneOptions.squareWave:
        return 'Square Wave';
      case RingtoneOptions.succade:
        return 'Succade';
      case RingtoneOptions.sunriseView:
        return 'Sunrise View';
      case RingtoneOptions.woodenPercussion:
        return 'Wooden Percussion';
      case RingtoneOptions.xtremeTone:
        return 'Xtreme Tone';
      default:
        return 'Silent'; // unreachable
    }
  }

  _resetSettings() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _conversationTones = prefs.setBool(SharedPreferencesHelpers.conversationTones, SharedPreferencesHelpers.defaultConversationTones).then((bool success) {
        return SharedPreferencesHelpers.defaultConversationTones;
      });
      _notificationTone = prefs.setInt(SharedPreferencesHelpers.notificationTone, null).then((bool success) {
        return null;
      });
      _popupNotification = prefs.setInt(SharedPreferencesHelpers.popupNotification, defaultPopupNotification.index).then((bool success) {
        return defaultPopupNotification;
      });
      _light = prefs.setInt(SharedPreferencesHelpers.light, defaultLight.index).then((bool success) {
        return defaultLight;
      });
      _useHighPriorityNotifications = prefs.setBool(SharedPreferencesHelpers.useHighPriorityNotifications, SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications).then((bool success) {
        return SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications;
      });

      _groupNotificationTone = prefs.setInt(SharedPreferencesHelpers.groupNotificationTone, null).then((bool success) {
        return null;
      });
      _groupVibrate = prefs.setInt(SharedPreferencesHelpers.groupVibrate, defaultGroupVibrate.index).then((bool success) {
        return defaultGroupVibrate;
      });
      _groupPopupNotification = prefs.setInt(SharedPreferencesHelpers.groupPopupNotification, defaultGroupPopupNotification.index).then((bool success) {
        return defaultGroupPopupNotification;
      });
      _groupLight = prefs.setInt(SharedPreferencesHelpers.groupLight, defaultGroupLight.index).then((bool success) {
        return defaultGroupLight;
      });
      _groupUseHighPriorityNotifications = prefs.setBool(SharedPreferencesHelpers.groupUseHighPriorityNotifications, SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications).then((bool success) {
        return SharedPreferencesHelpers.defaultGroupUseHighPriorityNotifications;
      });

      _callsRingtone = prefs.setInt(SharedPreferencesHelpers.callsRingtone, null).then((bool success) {
        return null;
      });
      _callsVibrate = prefs.setInt(SharedPreferencesHelpers.callsVibrate, defaultCallsVibrate.index).then((bool success) {
        return defaultCallsVibrate;
      });
    });
  }

  _setConversationTones(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _conversationTones = prefs.setBool(SharedPreferencesHelpers.conversationTones, value).then((bool success) {
        return value;
      });
    });
  }

  _setNotificationTone(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _notificationTone = prefs.setInt(SharedPreferencesHelpers.notificationTone, value).then((bool success) {
        return notificationToneOptionsList[value];
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

  _setUseHighPriorityNotifications(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _useHighPriorityNotifications = prefs.setBool(SharedPreferencesHelpers.useHighPriorityNotifications, value).then((bool success) {
        return value;
      });
    });
  }

  _setGroupNotificationTone(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _groupNotificationTone = prefs.setInt(SharedPreferencesHelpers.groupNotificationTone, value).then((bool success) {
        return notificationToneOptionsList[value];
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

  _setGroupUseHighPriorityNotifications(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _groupUseHighPriorityNotifications = prefs.setBool(SharedPreferencesHelpers.groupUseHighPriorityNotifications, value).then((bool success) {
        return value;
      });
    });
  }

  _setCallsRingtone(int value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _callsRingtone = prefs.setInt(SharedPreferencesHelpers.callsRingtone, value).then((bool success) {
        return ringtoneOptionsList[value];
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