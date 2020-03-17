import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/shared_preferences_helpers.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountSecuritySettingsScreen extends StatefulWidget {
  @override
  _AccountSecuritySettingsScreenState createState() => _AccountSecuritySettingsScreenState();

}

class _AccountSecuritySettingsScreenState extends State<AccountSecuritySettingsScreen> {

  Future<bool> _showSecurityNotifications;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // initialize variables
    _showSecurityNotifications = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool(SharedPreferencesHelpers.showSecurityNotifications) ?? SharedPreferencesHelpers.defaultShowSecurityNotifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _firstText = 'Your messages and calls are secured with '
      'end-to-end encryption, which means '
      'WhatzApp and third parties can\'t read or '
      'listen to them. ';
    final String _lastText = 'Turn on this setting to receive '
      'notifications when a contact\'s security '
      'code has changed. Your messages and '
      'calls are encrypted regardless of this '
      'setting.';
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SizedBox(
              height: 120,
              width: 120,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: secondaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 24.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: _firstText,
                    style: TextStyle(
                        color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  TextSpan(
                      text: 'Learn more',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        String url = 'https://www.whatsapp.com/security?lg=en&lc=US&eea=0';
                        _launchURL(url);
                      }
                  ),
                ]
              ),
            ),
          ),
          Divider(
            height: 16.0,
          ),
          FutureBuilder(
            future: _showSecurityNotifications,
            builder: (context, snapshot) {
              var onChanged;
              bool showSecurityNotifications = SharedPreferencesHelpers.defaultShowSecurityNotifications;
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
                    showSecurityNotifications = snapshot.data;
                    onChanged = (bool value) {
                      _setShowSecurityNotifications(value);
                    };
                  }
              }
              return ListTileTheme(
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: SwitchListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Show security notifications',
                    ),
                  ),
                  subtitle: Text(
                    _lastText,
                  ),
                  value: showSecurityNotifications,
                  activeColor: secondaryColor,
                  onChanged: onChanged,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _setShowSecurityNotifications(bool value) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _showSecurityNotifications = prefs.setBool(SharedPreferencesHelpers.showSecurityNotifications, value).then((bool success) {
        return value;
      });
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}