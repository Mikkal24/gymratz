// This is for testing login screen functionality

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymratz/screens/register.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/routes.dart';
// import 'package:mockito/mockito.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Login screen functionality', (WidgetTester tester) async {
    // arrange
    
    // act
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      initialRoute: '/',
    ));

    // expect LoginScreen from initialRoute
    expect(find.byType(LoginScreen), findsOneWidget);
    
    await tester.tap(find.byKey(LoginScreen.signUpButtonKey));
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(RegisterScreen), findsOneWidget);

  });
}
