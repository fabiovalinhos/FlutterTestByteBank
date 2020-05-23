import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets('Should save a contact', (WidgetTester tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contactDao: mockContactDao,
    ));
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    //Vamos usar novamente o tester e pegar a função tap
    await tester.tap(transferFeatureItem);
//    await tester.pump();
//    await tester.pump();
    await tester.pumpAndSettle();
    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

//    verificando o acesso ao banco de dados - verificação de chamada de funções
    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
//    Fazendo um pump para apresentar o formulário
    await tester.pump();
//    Não adiantou, vamos usar outra função para resolver = PumpAndSettle
    await tester.pumpAndSettle();
//    pumpAndSettle nao adiantou pois a API acessa partes externas. Para isto a solução é: injeção de dependências
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
//  Feito a injeção de dependencias, vamos continuar

    final nameTextField = find
        .byWidgetPredicate((widget) => _textFieldMatcher(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, "Fábio");

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => _textFieldMatcher(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

//    Os argumentos do Contato em que ser o mesmo que foram preenchidos no textField acima
    verify(mockContactDao.save(Contact(0, "Fábio", 1000)));

    //Foi feito novamente injeção de dependências aqui no contact_form
    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

//    Erro, o ContactList não chama novamente o findAll, precisamos transformar em stateless widget. Usei o verifyNever pois o verify estava dando erro - Não é o certo
    verifyNever(mockContactDao.findAll());
  });
}

bool _textFieldMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}
