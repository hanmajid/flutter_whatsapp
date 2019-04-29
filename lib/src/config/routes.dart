import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsapp/src/config/route_handlers.dart';

class Routes {
  static String root = '/';
  static String chatDetail = '/chat';
  static String chatMedia = '/chat/media';
  static String newChat = '/chat/new';
  static String newChatGroup = '/chat/new/group';
  static String newChatBroadcast = '/chat/new/broadcast';
  static String whatsappWeb = '/web';
  static String starredMessages = '/starred';

  static String contactsHelp = '/contacts/help';

  static String profile = '/profile';
  static String yourProfile = '/profile/you';

  static String settings = '/settings';
  static String accountSettings = '/settings/accounts';
  static String chatsSettings = '/settings/chats';
  static String notificationsSettings = '/settings/notifications';
  static String dataSettings = '/settings/data';
  static String helpSettings = '/settings/help';

  static String statusDetail = '/status';
  static String newStatus = '/status/new';
  static String newTextStatus = '/status/new/text';
  static String statusPrivacy = '/status/privacy';

  static String callDetail = '/call';
  static String newCall = '/call/new';
  static String clearCallLog = '/call/clear';

  static String editImage = '/edit/image';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('Route was not found.');
      }
    );
    router.define(root, handler: rootHandler);

    router.define(chatDetail, handler: chatDetailHandler);
    router.define(chatMedia, handler: chatMediaHandler);
    router.define(newChat, handler: newChatHandler);
    router.define(newChatGroup, handler: newChatGroupHandler);
    router.define(newChatBroadcast, handler: newChatBroadcastHandler);
    router.define(whatsappWeb, handler: whatsappWebHandler);
    router.define(starredMessages, handler: starredMessagesHandler);

    router.define(contactsHelp, handler: contactsHelpHandler);

    router.define(profile, handler: profileHandler);
    router.define(yourProfile, handler: yourProfileHandler);

    router.define(settings, handler: settingsHandler);
    router.define(accountSettings, handler: accountSettingsHandler);
    router.define(chatsSettings, handler: chatsSettingsHandler);
    router.define(notificationsSettings, handler: notificationsSettingsHandler);
    router.define(dataSettings, handler: dataSettingsHandler);
    router.define(helpSettings, handler: helpSettingsHandler);

    router.define(statusDetail, handler: statusDetailHandler);
    router.define(newStatus, handler: newStatusHandler);
    router.define(newTextStatus, handler: newTextStatusHandler);
    router.define(statusPrivacy, handler: statusPrivacyHandler);

    router.define(callDetail, handler: callDetailHandler);
    router.define(newCall, handler: newCallHandler);
    router.define(clearCallLog, handler: clearCallLogHandler);

    router.define(editImage, handler: editImageHandler);
  }
}