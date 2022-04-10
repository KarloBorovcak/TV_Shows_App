import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/widgets/login_ui.dart';
import 'package:tv_shows/widgets/materialapp_scaffold.dart';

void main() {
  group('LoginUI test:', () {
    testWidgets('email input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: LoginUI(
            title: 'Login',
            description: 'In order to continue please log in.',
            buttonTitle: 'Login',
            isLoading: false,
            showOtherButtonTitle: 'Create account',
            buttonPressed: (email, password) {},
            showOtherButtonPressed: () {},
          ),
        ),
      );

      final emailTextField = find.byKey(const ValueKey('emailTextField'));

      await tester.enterText(emailTextField, '123@gmail.com');

      expect(find.text('123@gmail.com'), findsOneWidget);
    });

    testWidgets('password input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: LoginUI(
            title: 'Login',
            description: 'In order to continue please log in.',
            buttonTitle: 'Login',
            isLoading: false,
            showOtherButtonTitle: 'Create account',
            buttonPressed: (email, password) {},
            showOtherButtonPressed: () {},
          ),
        ),
      );

      final passwordTextField = find.byKey(const ValueKey('passwordTextField'));

      await tester.enterText(passwordTextField, '111111');

      expect(find.text('111111'), findsOneWidget);
    });

    testWidgets('loading indicator showing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialAppAndScaffold(
          child: LoginUI(
            title: 'Login',
            description: 'In order to continue please log in.',
            buttonTitle: 'Login',
            isLoading: true,
            showOtherButtonTitle: 'Create account',
            buttonPressed: (email, password) {},
            showOtherButtonPressed: () {},
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
