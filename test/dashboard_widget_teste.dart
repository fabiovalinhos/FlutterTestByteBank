import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

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

//    Código antigo, primeira maneira usando o widgetwith_etc
//    final iconTransferFeatureIcon =
//        find.widgetWithIcon(FeatureItem, Icons.monetization_on);
//    expect(iconTransferFeatureIcon, findsOneWidget);
//    final nameTransferFeatureIcon =
//        find.widgetWithText(FeatureItem, 'Transfer');
//    expect(nameTransferFeatureIcon, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((Widget widget) =>
        featureItemMatcher(widget, "Transfer", Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed feature when the Dashboard is open',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, "Transaction Feed", Icons.description));
    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}
