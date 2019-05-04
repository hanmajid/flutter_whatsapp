import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/widgets/setting_item.dart';
import 'package:flutter_whatsapp/src/widgets/switch_setting_item.dart';

class ChatsSettingsScreen extends StatefulWidget {
  @override
  _ChatsSettingsScreenState createState() => _ChatsSettingsScreenState();
}

class _ChatsSettingsScreenState extends State<ChatsSettingsScreen> {
  bool _enterIsSend = false;
  bool _mediaVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchSettingItem(
            title: 'Enter is send',
            subtitle: 'Enter key will send your message',
            onChanged: (bool value){
              setState(() {
                _enterIsSend = value;
              });
            },
            value: _enterIsSend,
            padding: EdgeInsets.only(right: 16.0, left: 70.0, top: 12.0, bottom: 12.0),
          ),
          SwitchSettingItem(
            title: 'Media visibility',
            subtitle: 'Show newly downloaded media in your phone\'s gallery',
            onChanged: (bool value){
              setState(() {
                _mediaVisibility = value;
              });
            },
            value: _mediaVisibility,
            padding: EdgeInsets.only(right: 16.0, left: 70.0, top: 12.0, bottom: 12.0),
          ),
          SettingItem(
            title: 'Font size',
            subtitle: 'Medium',
            onTap: (){},
            padding: EdgeInsets.only(right: 16.0, left: 70.0,),
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
            onTap: (){},
          ),
          SettingItem(
            icon: Icons.history,
            title: 'Chat history',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            onTap: (){},
          ),
        ],
      ),
    );
  }

}