import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should display the main image when the Dashboard this opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the transfer feature when the Dashboard is open',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final iconTransferFeatureIcon =
        find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    expect(iconTransferFeatureIcon, findsOneWidget);
    final nameTransferFeatureIcon =
        find.widgetWithText(FeatureItem, 'Transfer');
    expect(nameTransferFeatureIcon, findsOneWidget);
  });
}
