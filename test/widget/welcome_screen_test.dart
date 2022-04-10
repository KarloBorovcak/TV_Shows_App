import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:tv_shows/screens/login/welcome_screen.dart';

void main() {
  String email = '123@gmail.com';
  group('Welcome screen test:', () {
    testWidgets('displays email', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WelcomeScreen(email: email),
      ));

      expect(find.text('Welcome, $email!'), findsOneWidget);
    });

    testWidgets('displays animation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WelcomeScreen(email: email),
      ));

      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('displays svg image', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WelcomeScreen(email: email),
      ));

      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
