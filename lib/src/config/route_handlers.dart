import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/home.dart';
import 'package:flutter_whatsapp/src/screens/camera_screen.dart';
import 'package:flutter_whatsapp/src/screens/chat_media_screen.dart';
import 'package:flutter_whatsapp/src/screens/contacts/contacs_help_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_call_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_chat_screen.dart';
import 'package:flutter_whatsapp/src/screens/detail_status_screen.dart';
import 'package:flutter_whatsapp/src/screens/edit_image_screen.dart';
import 'package:flutter_whatsapp/src/screens/future_todo_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_call_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_broadcast_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_group_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_chat_screen.dart';
import 'package:flutter_whatsapp/src/screens/new_text_status_screen.dart';
import 'package:flutter_whatsapp/src/screens/profile_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_changenum_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_delete_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_enable_twostep_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_privacy_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_request_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_security_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/account_twostep_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/privacy/privacy_blocked_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account/privacy/privacy_livelocation_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/account_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/chats_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/data_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/help/help_appinfo_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/help/help_contact_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/help/licenses_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/help_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/notifications_settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings/your_profile_screen.dart';
import 'package:flutter_whatsapp/src/screens/settings_screen.dart';
import 'package:flutter_whatsapp/src/screens/starred_messages_screen.dart';
import 'package:flutter_whatsapp/src/screens/status_privacy_screen.dart';
import 'package:flutter_whatsapp/src/screens/whatsapp_web_scan_screen.dart';
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
          return OKCancelDialog(
            title: 'Do you want to clear your entire call log?',
            ok: 'OK',
            cancel: 'CANCEL',
          );
        }
      );
      return null;
    }
);

var logoutDeviceHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      showDialog(
          context: context,
          builder: (context) {
            return OKCancelDialog(
              title: 'Log out from this device?',
              ok: 'LOG OUT',
              cancel: 'CANCEL',
            );
          }
      );
      return null;
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

var logoutAllDevicesHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      showDialog(
          context: context,
          builder: (context) {
            return OKCancelDialog(
              title: 'Are you sure you want to log out from all devices?',
              ok: 'LOG OUT',
              cancel: 'CANCEL',
            );
          }
      );
      return null;
    }
);

var contactsHelpHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new ContactsHelpScreen();
    }
);

var profileHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      // int id = int.tryParse(params['id']?.first) ?? null;

      return new ProfileScreen(
      );
    }
);

var yourProfileHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {

      return new YourProfileScreen(
      );
    }
);

var chatMediaHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      // int id = int.tryParse(params['id']?.first) ?? null;

      return new ChatMediaScreen();
    }
);

var accountSettingsHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountSettingsScreen();
    }
);
var chatsSettingsHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new ChatsSettingsScreen();
    }
);
var notificationsSettingsHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NotificationsSettingsScreen();
    }
);
var dataSettingsHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new DataSettingsScreen();
    }
);
var helpSettingsHandler  = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HelpSettingsScreen();
    }
);
var helpContactSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HelpContactSettingsScreen();
    }
);
var helpAppInfoSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new HelpAppInfoSettingsScreen();
    }
);
var accountPrivacySettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountPrivacySettingsScreen();
    }
);
var accountSecuritySettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountSecuritySettingsScreen();
    }
);
var accountTwoStepSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountTwoStepSettingsScreen();
    }
);
var accountEnableTwoStepSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountEnableTwoStepSettingsScreen();
    }
);
var accountChangeNumSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountChangeNumSettingsScreen();
    }
);
var accountRequestSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountRequestSettingsScreen();
    }
);
var accountDeleteSettingsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new AccountDeleteSettingsScreen();
    }
);

var licensesHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new LicensesScreen();
    }
);

var futureTodoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new FutureTodoScreen();
    }
);

var whatsappWebScanHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new WhatsappWebScanScreen();
    }
);

var privacyLiveLocationHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PrivacyLiveLocationScreen();
    }
);

var privacyBlockedHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PrivacyBlockedScreen();
    }
);

class OKCancelDialog extends StatelessWidget {

  final String title;
  final String ok;
  final String cancel;

  OKCancelDialog({this.title, this.ok, this.cancel});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      actions: <Widget>[
        Material(
          child: FlatButton(
            child: Text(
              cancel,
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
            ok,
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

}