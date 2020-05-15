import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dashboard_widget_teste.dart';
import 'matchers.dart';

void main() {
  testWidgets('Should save a contact', (WidgetTester tester) async {
    await tester.pumpWidget(BytebankApp());
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    //Vamos usar novamente o tester e pegar a função tap
    await tester.tap(transferFeatureItem);
    await tester.pump();
    await tester.pump();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
//    Fazendo um pump para apresentar o formulário
    await tester.pump();
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
  });
}
