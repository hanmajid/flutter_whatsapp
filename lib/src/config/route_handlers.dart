import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/home.dart';
import 'package:flutter_whatsapp/src/screens/camera_screen.dart';
import 'package:flutter_whatsapp/src/screens/contacts/contacs_help_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_call_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_chat_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_status_screen.dart';
import 'package:flutter_whatsapp/src/screens/edit_image_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_call_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_broadcast_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_group_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_text_status_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/starred_messages_screen.dart';
import 'package:flutter_whatsapp/src/screens/status_privacy_screen.dart';
import 'package:flutter_whatsapp/src/screens/whatsapp_web_screen.dart';
import 'package:flutter_whatsapp/src/values/colors.dart';

var rootHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new Home();
  }
);

var chatDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      int profileId = int.tryParse(params['profileId']?.first) ?? null;

      return new DetailChatScreen(
        id: profileId,
      );
    }
);

var newChatHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NewChatScreen();
    }
);

var newChatGroupHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NewChatGroupScreen();
    }
);

var newChatBroadcastHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NewChatBroadcastScreen();
    }
);

var whatsappWebHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new WhatsappWebScreen();
    }
);

var starredMessagesHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new StarredMessagesScreen();
    }
);

var settingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new SettingsScreen();
    }
);

var statusDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      int id = int.tryParse(params['id']?.first) ?? null;

      return new DetailStatusScreen(
        id: id,
      );
    }
);

var newStatusHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new CameraScreen();
    }
);

var newTextStatusHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NewTextStatusScreen();
    }
);

var statusPrivacyHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new StatusPrivacyScreen();
    }
);

var callDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      int id = int.tryParse(params['id']?.first) ?? null;

      return new DetailCallScreen(
        id: id,
      );
    }
);

var newCallHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NewCallScreen();
    }
);

var clearCallLogHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text(
                'Do you want to clear your entire call log?',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            actions: <Widget>[
              Material(
                child: FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                        color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ),
              FlatButton(
                child: Text(
                    'OK',
                  style: TextStyle(
                      color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
      );
    }
);

var editImageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String id = params['id']?.first;
      String resource = params['resource']?.first;

      print('!!!!!!!!!!!!!!!!! $id : $resource');

      return new EditImageScreen(
        id: id,
        resource: Uri.decodeComponent(resource),
      );
    }
);

var contactsHelpHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new ContactsHelpScreen();
    }
);