import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_whatsapp/main.dart' as app;

void main() {
  group('Bob App', () {
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

      // is fab on chat screen clickable
      await tester.tap(fab);
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
      await tester.tap(newTextStatus);
      await tester.pumpAndSettle();
      await tester.enterText(textField, 'Hacked');
      await tester.pumpAndSettle();
    });
  });}


