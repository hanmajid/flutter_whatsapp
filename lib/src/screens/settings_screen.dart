import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/application.dart';
import 'package:flutter_whatsapp/src/config/routes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            leading: Hero(
              tag: 'profile-pic',
              child: CircleAvatar(
                radius: 32.0,
                backgroundImage: CachedNetworkImageProvider('https://via.placeholder.com/200x200'),
              ),
            ),
            title: Text(
              'NAME',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'STATUS',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            onTap: (){
              Application.router.navigateTo(
                context,
                Routes.yourProfile,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          Divider(height: 0.0,),
          _buildSettingMenu(Icons.vpn_key, 'Account', 'Privacy, security, change number', (){
            Application.router.navigateTo(
              context,
              Routes.accountSettings,
              transition: TransitionType.inFromRight,
            );
          }),
          _buildSettingMenu(Icons.chat, 'Chats', 'Backup, history, wallpaper', (){
            Application.router.navigateTo(
              context,
              Routes.chatsSettings,
              transition: TransitionType.inFromRight,
            );
          }),
          _buildSettingMenu(Icons.notifications, 'Notifications', 'Message, group & call tones', (){
            Application.router.navigateTo(
              context,
              Routes.notificationsSettings,
              transition: TransitionType.inFromRight,
            );
          }),
          _buildSettingMenu(Icons.data_usage, 'Data and storage usage', 'Network usage, auto-download', (){
            Application.router.navigateTo(
              context,
              Routes.dataSettings,
              transition: TransitionType.inFromRight,
            );
          }),
          _buildSettingMenu(Icons.help_outline, 'Help', 'FAQ, contact us, privacy policy', (){
            Application.router.navigateTo(
              context,
              Routes.helpSettings,
              transition: TransitionType.inFromRight,
            );
          }),
          Divider(indent: 72.0, height: 0.0,),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Container(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.group,
                color: Color.fromRGBO(7, 94, 84, 0.7),
              ),
            ),
            title: Text(
              'Invite a friend',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: (){},
          )
        ],
      )
    );
  }

  Widget _buildSettingMenu(IconData icon, String title, String subtitle, Function onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Color.fromRGBO(7, 94, 84, 0.7),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
          subtitle
      ),
      onTap: onTap,
    );
  }
}