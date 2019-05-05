import 'package:flutter/material.dart';
import 'package:platform/platform.dart';
import 'package:android_intent/android_intent.dart';

class AndroidIntentHelpers {
  static void inviteFriend(BuildContext context) {
    if (const LocalPlatform().isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SENDTO',
        data: Uri.encodeFull('mailto:'),
        arguments: <String, dynamic>{
          //'sms_body': 'Body Create a Flutter app',
          'android.intent.extra.TITLE': 'Invite a friend via...',
          'android.intent.extra.SUBJECT': 'WhatzApp Messenger: Android + iPhone + Windows Phone',
          'android.intent.extra.TEXT': 'Hey,\n\nWhatzApp Messenger is a fast, simple and secure app that I use to message and call the people I care about.\n\nGet it for free at https://whatsapp.com/download/',
        },
      );
      intent.launch();
    }
    else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Sorry, this only works in Android.'))
      );
    }
  }

  static void openContactApp(BuildContext context) {
    if (const LocalPlatform().isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('content://contacts/people'),
      );
      intent.launch();
    }
    else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Sorry, this only works in Android.'))
      );
    }
  }

  static void createContact(BuildContext context) {
    if (const LocalPlatform().isAndroid) {
      final AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.INSERT',
        data: Uri.encodeFull('content://contacts/people'),
      );
      intent.launch();
    }
    else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Sorry, this only works in Android.'))
      );
    }
  }
}