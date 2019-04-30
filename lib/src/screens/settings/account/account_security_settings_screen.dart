import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

class AccountSecuritySettingsScreen extends StatefulWidget {
  @override
  _AccountSecuritySettingsScreenState createState() => _AccountSecuritySettingsScreenState();

}

class _AccountSecuritySettingsScreenState extends State<AccountSecuritySettingsScreen> {
  bool _showSecurityNotifications = false;

  @override
  Widget build(BuildContext context) {
    final String _firstText = 'Your messages and calls are secured with '
      'end-to-end encryption, which means '
      'WhatsApp and third parties can\'t read or '
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

                      }
                  ),
                ]
              ),
            ),
          ),
          Divider(
            height: 16.0,
          ),
          ListTileTheme(
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
              value: _showSecurityNotifications,
              activeColor: secondaryColor,
              onChanged: (bool value) {
                setState(() {
                  _showSecurityNotifications = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }

}