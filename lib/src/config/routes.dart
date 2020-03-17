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
  static String whatsappWebScan = '/web/scan';
  static String logoutDevice = '/web/logout';
  static String logoutAllDevices = '/web/logout/all';
  static String starredMessages = '/starred';

  static String contactsHelp = '/contacts/help';

  static String profile = '/profile';
  static String yourProfile = '/profile/you';

  static String settings = '/settings';
  static String accountSettings = '/settings/accounts';
  static String accountPrivacySettings = '/settings/accounts/privacy';
  static String privacyLiveLocation = '/settings/accounts/privacy/live_location';
  static String privacyBlocked = '/settings/accounts/privacy/blocked';
  static String accountSecuritySettings = '/settings/accounts/security';
  static String accountTwoStepSettings = '/settings/accounts/two_step';
  static String accountEnableTwoStepSettings = '/settings/accounts/two_step/enable';
  static String accountChangeNumSettings = '/settings/accounts/change_num';
  static String accountRequestSettings = '/settings/accounts/request';
  static String accountDeleteSettings = '/settings/accounts/delete';
  static String chatsSettings = '/settings/chats';
  static String notificationsSettings = '/settings/notifications';
  static String dataSettings = '/settings/data';
  static String helpSettings = '/settings/help';
  static String helpContactSettings = '/settings/help/contact';
  static String helpAppInfoSettings = '/settings/help/app_info';
  static String licenses = '/licenses';

  static String statusDetail = '/status';
  static String newStatus = '/status/new';
  static String newTextStatus = '/status/new/text';
  static String statusPrivacy = '/status/privacy';

  static String callDetail = '/call';
  static String newCall = '/call/new';
  static String clearCallLog = '/call/clear';

  static String editImage = '/edit/image';

  static String futureTodo = '/future';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('Route was not found.');
        return null;
      }
    );
    router.define(root, handler: rootHandler);

    router.define(chatDetail, handler: chatDetailHandler);
    router.define(chatMedia, handler: chatMediaHandler);
    router.define(newChat, handler: newChatHandler);
    router.define(newChatGroup, handler: newChatGroupHandler);
    router.define(newChatBroadcast, handler: newChatBroadcastHandler);
    router.define(whatsappWeb, handler: whatsappWebHandler);
    router.define(whatsappWebScan, handler: whatsappWebScanHandler);
    router.define(logoutDevice, handler: logoutDeviceHandler);
    router.define(logoutAllDevices, handler: logoutAllDevicesHandler);
    router.define(starredMessages, handler: starredMessagesHandler);

    router.define(contactsHelp, handler: contactsHelpHandler);

    router.define(profile, handler: profileHandler);
    router.define(yourProfile, handler: yourProfileHandler);

    router.define(settings, handler: settingsHandler);
    router.define(accountSettings, handler: accountSettingsHandler);
    router.define(accountPrivacySettings, handler: accountPrivacySettingsHandler);
    router.define(privacyLiveLocation, handler: privacyLiveLocationHandler);
    router.define(privacyBlocked, handler: privacyBlockedHandler);
    router.define(accountSecuritySettings, handler: accountSecuritySettingsHandler);
    router.define(accountTwoStepSettings, handler: accountTwoStepSettingsHandler);
    router.define(accountEnableTwoStepSettings, handler: accountEnableTwoStepSettingsHandler);
    router.define(accountChangeNumSettings, handler: accountChangeNumSettingsHandler);
    router.define(accountRequestSettings, handler: accountRequestSettingsHandler);
    router.define(accountDeleteSettings, handler: accountDeleteSettingsHandler);

    router.define(chatsSettings, handler: chatsSettingsHandler);
    router.define(notificationsSettings, handler: notificationsSettingsHandler);
    router.define(dataSettings, handler: dataSettingsHandler);
    router.define(helpSettings, handler: helpSettingsHandler);
    router.define(helpContactSettings, handler: helpContactSettingsHandler);
    router.define(helpAppInfoSettings, handler: helpAppInfoSettingsHandler);
    router.define(licenses, handler: licensesHandler);

    router.define(statusDetail, handler: statusDetailHandler);
    router.define(newStatus, handler: newStatusHandler);
    router.define(newTextStatus, handler: newTextStatusHandler);
    router.define(statusPrivacy, handler: statusPrivacyHandler);

    router.define(callDetail, handler: callDetailHandler);
    router.define(newCall, handler: newCallHandler);
    router.define(clearCallLog, handler: clearCallLogHandler);

    router.define(editImage, handler: editImageHandler);

    router.define(futureTodo, handler: futureTodoHandler);
  }
}