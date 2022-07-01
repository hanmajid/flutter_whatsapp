import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_whatsapp/main.dart' as app;

void main() {
  group('Flutter WhatsApp App', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      final tab3 = find.byKey(Key('Status'));
      final newTextStatus = find.byIcon(Icons.edit);
      final textField = find.byType(TextField);
      final tab4 = find.byKey(Key('Calls'));
      final fab1 = find.byType(FloatingActionButton);
      final callArrow = find.byIcon(Icons.arrow_back);
      final moreOpts = find.byKey(Key('moreOptions'));
      final whatsAppWeb = find.byKey(Key('Web'));
      final webArrow = find.byIcon(Icons.arrow_back);
      //final iconAdd = find.byIcon(Icons.add);
      //final scanArrow = find.byTooltip('back');
      final starredMsg = find.byKey(Key('Starred'));
      final starredArrow = find.byIcon(Icons.arrow_back);
      final settings = find.byKey(Key('Settings'));
      final settingsArrow = find.byIcon(Icons.arrow_back);
      final circleAvatar = find.byType(CircleAvatar);
      final profileArrow = find.byIcon(Icons.arrow_back);
      final account = find.byIcon(Icons.vpn_key);
      final privacy = find.byIcon(Icons.lock);
      final receipts = find.byKey(Key('Receipts'));
      final privacyArrow = find.byIcon(Icons.arrow_back);
      final security = find.byIcon(Icons.security);
      final securityNotifications = find.byKey(Key('Security_notifications'));
      final securityArrow = find.byIcon(Icons.arrow_back);
      final accountArrow = find.byIcon(Icons.arrow_back);
      final twoStep = find.byIcon(Icons.verified_user);
      final twoStepArrow = find.byIcon(Icons.arrow_back);
      final chats = find.byIcon(Icons.chat);
      final enterIsSend = find.byKey(Key('Enter_is_Send'));
      final mediaVisibilty = find.byKey(Key('Visibility'));
      final chatsArrow = find.byIcon(Icons.arrow_back);
      final notifications = find.byIcon(Icons.notifications);
      final notificationsArrow = find.byIcon(Icons.arrow_back);
      final conversationTones = find.byKey(Key('Conversation tones'));
      final highPriorityNotifications =
          find.byKey(Key('High_priority_notifications'));
      final groupHighPriorityNotifications =
          find.byKey(Key('Group_high_priority_notifications'));
      final popupMenuButton = find.byKey(Key('popupMenu'));
      final popupMenuItem = find.byKey(Key('RNS'));
      final listView = find.byKey(Key('ListView'));
      final searchIcon = find.byIcon(Icons.search);
      final searchArrow = find.byIcon(Icons.arrow_back);
      final colorIcon = find.byIcon(Icons.color_lens);
      final chat1 = find.text('Chris');
      //final arrowChat1 = find.byIcon(Icons.arrow_back);
      //final videoIcon = find.byIcon(Icons.videocam);
      //final callIcon = find.byIcon(Icons.call);
      //final toolTip = find.byTooltip('More options');
      //final textField1 = find.byType(TextField);
      //final sendIcon = find.byIcon(Icons.send);
      //final status2 = find.text('Cindy');
      //final statusArrow = find.byIcon(Icons.arrow_back);

      // is fab on chat screen clickable
      await tester.tap(fab);
      await tester.pumpAndSettle();

      //await tester.tap(chat1);
      //await tester.pumpAndSettle();
      //await tester.tap(videoIcon);
      //await tester.pumpAndSettle();
      //await tester.tap(callIcon);
      //await tester.pumpAndSettle();
      //await tester.tap(toolTip);
      //await tester.pumpAndSettle();
      //await tester.enterText(textField1,'test');
      //await tester.pumpAndSettle();
      //await tester.tap(sendIcon);
      //await tester.pumpAndSettle();
      //await tester.tap(arrowChat1);
      //await tester.pumpAndSettle();

      // test search icon
      await tester.tap(searchIcon);
      await tester.pumpAndSettle();
      await tester.tap(searchArrow);
      await tester.pumpAndSettle();

      // test navigation to whatsApp web screen
      await tester.tap(moreOpts);
      await tester.pumpAndSettle();
      await tester.tap(whatsAppWeb);
      await tester.pumpAndSettle();
      await tester.tap(webArrow);
      await tester.pumpAndSettle();

      // test navigation to starred messages
      await tester.tap(moreOpts);
      await tester.pumpAndSettle();
      await tester.tap(starredMsg);
      await tester.pumpAndSettle();
      await tester.tap(starredArrow);
      await tester.pumpAndSettle();

      // test navigation to settings
      await tester.tap(moreOpts);
      await tester.pumpAndSettle();
      await tester.tap(settings);
      await tester.pumpAndSettle();

      //test navigation to profile screen
      await tester.tap(circleAvatar);
      await tester.pumpAndSettle();
      await tester.tap(profileArrow);
      await tester.pumpAndSettle();

      //test navigation to account screen
      await tester.tap(account);
      await tester.pumpAndSettle();

      //test navigation to account_privacy_settings screen
      await tester.tap(privacy);
      await tester.pumpAndSettle();
      await tester.tap(receipts);
      await tester.pumpAndSettle();
      await tester.tap(privacyArrow);
      await tester.pumpAndSettle();

      //test navigation to account_security_settings screen
      await tester.tap(security);
      await tester.pumpAndSettle();
      await tester.tap(securityNotifications);
      await tester.pumpAndSettle();
      await tester.tap(securityArrow);
      await tester.pumpAndSettle();

      //test navigation to account_two-step verification_settings screen
      await tester.tap(twoStep);
      await tester.pumpAndSettle();
      await tester.tap(twoStepArrow);
      await tester.pumpAndSettle();

      //test navigation from account screen
      await tester.tap(accountArrow);
      await tester.pumpAndSettle();

      //test navigation to chat_settings_screen
      await tester.tap(chats);
      await tester.pumpAndSettle();
      await tester.tap(enterIsSend);
      await tester.pumpAndSettle();
      await tester.tap(mediaVisibilty);
      await tester.pumpAndSettle();

      //test navigation from chats_settings_screen
      await tester.tap(chatsArrow);
      await tester.pumpAndSettle();

      //test navigation to notifications_settings_screen
      await tester.tap(notifications);
      await tester.pumpAndSettle();
      //await tester.tap(conversationTones);
      //await tester.pumpAndSettle();
      //await tester.tap(highPriorityNotifications);
      //await tester.pumpAndSettle();
      //await tester.tap(groupHighPriorityNotifications);
      //await tester.pumpAndSettle();
      await tester.tap(popupMenuButton);
      await tester.pumpAndSettle();
      await tester.tap(popupMenuItem);
      await tester.pumpAndSettle();

      //test navigation from notifications_settings_screen
      await tester.tap(notificationsArrow);
      await tester.pumpAndSettle();

      //test navigation from settings screen
      await tester.tap(settingsArrow);
      await tester.pumpAndSettle();

      //test navigation to new call screen
      await tester.tap(tab4);
      await tester.pumpAndSettle();
      await tester.tap(fab1);
      await tester.pumpAndSettle();
      await tester.tap(callArrow);
      await tester.pumpAndSettle();

      //test status update via text
      await tester.tap(tab3);
      await tester.pumpAndSettle();
      //await tester.tap(chat1);
      //await tester.pumpAndSettle();
      //await tester.tap(statusArrow);
      await tester.tap(newTextStatus);
      await tester.pumpAndSettle();
      await tester.tap(colorIcon);
      await tester.pumpAndSettle();
      await tester.tap(colorIcon);
      await tester.pumpAndSettle();
      await tester.enterText(textField, 'Hacked');
      await tester.pumpAndSettle();
    });
  });
}
