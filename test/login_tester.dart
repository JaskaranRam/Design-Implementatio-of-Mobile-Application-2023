import 'package:dreamy_tales/pages/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import './mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets("Login Empty Input", (tester) async {
    //Firebase.initializeApp();
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final emailField = find.byKey(const Key("mail"));
    expect(emailField, findsOneWidget);

    final passwordField = find.byKey(const Key("password"));
    expect(passwordField, findsOneWidget);

    final button = find.byKey(const Key("login/register"));

    await tester.tap(button);
    await tester.pump();

    final errorMessage = find.byKey(const Key("errorMessage"));
    expect(errorMessage, findsOneWidget);
    expect(errorMessage.toString(), isNotNull);
  });

  testWidgets("login With Correct Input", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    final emailField = find.byKey(const Key("mail"));
    expect(emailField, findsOneWidget);

    final passwordField = find.byKey(const Key("password"));
    expect(passwordField, findsOneWidget);


    final button = find.byKey(const Key("login/register"));

    await tester.enterText(emailField, "gabbone123456@gmail.com");
    await tester.enterText(passwordField, "123456");

    await tester.tap(button);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // Trova il widget della casella di testo dell'errore
    final errorMessageWidget = find.byKey(const Key("errorMessage"));
    expect(errorMessageWidget, findsOneWidget);

    // Ottieni il widget Text dalla casella di testo dell'errore
    final errorMessageTextWidget = tester.widget<Text>(errorMessageWidget);
    // Ottieni il testo attuale dal widget Text
    final errorMessageText = errorMessageTextWidget.data;
    if(errorMessageText != null)
      print (errorMessageText);
    else
      print("errorMessageText is null");

    //expect(find.byType(MyHomePage), findsOneWidget);
  });

  testWidgets("Check Forgot Password Button", (tester) async {
    // Crea una chiave univoca
    final forgotPasswordButtonKey = Key("forgotPassword");

    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    final forgotPasswordButton = find.byKey(forgotPasswordButtonKey);
    expect(forgotPasswordButton, findsOneWidget);

    // Tappa sul pulsante
    await tester.tap(forgotPasswordButton);
    await tester.pumpAndSettle();

    // Verifica che la dialog sia stata visualizzata
    final dialog = find.byType(Dialog);
    expect(dialog, findsOneWidget);

  });
}

