import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/helpers/dialog_helpers.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item_header.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';

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

var NotificationToneOptionsList = [
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

var VibrateOptionsList = [
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

var PopupNotificationOptionsList = [
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

var LightOptionsList = [
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

var RingtoneOptionsList = [
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
  bool _conversationTones = false;
  bool _highPriorityNotifications = true;
  bool _groupHighPriorityNotifications = false;

  NotificationToneOptions _notificationToneOptions;
  VibrateOptions _vibrate = VibrateOptions.off;
  PopupNotificationOptions _popupNotification = PopupNotificationOptions.noPopup;
  LightOptions _light = LightOptions.white;

  NotificationToneOptions _groupNotificationToneOptions;
  VibrateOptions _groupVibrate = VibrateOptions.off;
  PopupNotificationOptions _groupPopupNotification = PopupNotificationOptions.noPopup;
  LightOptions _groupLight = LightOptions.white;

  VibrateOptions _callVibrate = VibrateOptions.off;

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
          SwitchSettingItem(
            title: 'Conversation tones',
            subtitle: 'Play sounds for incoming and outgoing messages.',
            value: _conversationTones,
            onChanged: (bool value) {
              setState((){
                _conversationTones = value;
              });
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
          SettingItem(
            title: 'Vibrate',
            subtitle: _getVibrateText(_vibrate),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(VibrateOptionsList, 'Vibrate', _getVibrateText, context, _vibrate, (value) {
                setState(() {
                  _vibrate = value;
                });
              });
            },
          ),
          SettingItem(
            title: 'Popup notification',
            subtitle: _getPopupNotificationText(_popupNotification),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(PopupNotificationOptionsList, 'Popup notification', _getPopupNotificationText, context, _popupNotification, (value) {
                setState(() {
                  _popupNotification = value;
                });
              });
            },
          ),
          SettingItem(
            title: 'Light',
            subtitle: _getLightText(_light),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(LightOptionsList, 'Light', _getLightText, context, _light, (value) {
                setState(() {
                  _light= value;
                });
              });
            },
          ),
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
          SettingItem(
            title: 'Vibrate',
            subtitle: _getVibrateText(_groupVibrate),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(VibrateOptionsList, 'Vibrate', _getVibrateText, context, _groupVibrate, (value) {
                setState(() {
                  _groupVibrate = value;
                });
              });
            },
          ),
          SettingItem(
            title: 'Popup notification',
            subtitle: _getPopupNotificationText(_groupPopupNotification),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(PopupNotificationOptionsList, 'Popup notification', _getPopupNotificationText, context, _groupPopupNotification, (value) {
                setState(() {
                  _groupPopupNotification = value;
                });
              });
            },
          ),
          SettingItem(
            title: 'Light',
            subtitle: _getLightText(_groupLight),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(LightOptionsList, 'Light', _getLightText, context, _groupLight, (value) {
                setState(() {
                  _groupLight = value;
                });
              });
            },
          ),
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
          SettingItem(
            title: 'Vibrate',
            subtitle: _getVibrateText(_callVibrate),
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            onTap: (){
              DialogHelpers.showRadioDialog(VibrateOptionsList, 'Vibrate', _getVibrateText, context, _callVibrate, (value) {
                setState(() {
                  _callVibrate = value;
                });
              });
            },
          ),
          SizedBox(
            height: 8.0,
          )
        ],
      ),
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
}