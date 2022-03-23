import 'package:flutter/material.dart';
import 'package:tv_shows/screens/login/base_login_screen.dart';
import 'package:tv_shows/screens/login/welcome_screen.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: BaseLoginScreen(
        title: 'Login',
        description: 'In order to continue please log in.',
        buttonTitle: 'Login',
        showOtherButtonTitle: 'Create account',
        buttonPressed: () {
          final route = MaterialPageRoute(builder: (_) => const WelcomeScreen(email: 'Test'));
          Navigator.of(context).push(route);
        },
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(builder: (_) => const RegisterScreen());
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
