import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_whatsapp/src/app.dart';

void main() {
  testWidgets('test app bar', (WidgetTester tester)async {
    await tester.pumpWidget(FlutteredApp());
    var appbar = find.byType(AppBar);
    expect(appbar,findsOneWidget);
  });
}