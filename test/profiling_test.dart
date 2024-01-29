import 'package:dreamy_tales/pages/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dreamy_tales/pages/profiling_page.dart';

void main() {
  testWidgets('ChildProfilePage should build without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ChildProfilePage()));
    expect(find.byType(ChildProfilePage), findsOneWidget);
  });

  testWidgets('ChildProfilePage should navigate to MyHomePage after saving', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ChildProfilePage(),
    ));

    // Simula l'inserimento del nome
    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.pump();

    // Simula l'inserimento dell'età
    await tester.enterText(find.byType(TextField), '5');
    await tester.pump();

    // Simula la selezione dell'avatar
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    
  });


  // Aggiungi ulteriori test secondo le tue esigenze
}