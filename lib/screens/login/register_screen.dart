import 'package:flutter/material.dart';
import 'package:tv_shows/screens/login/base_login_screen.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: BaseLoginScreen(
        title: 'Register',
        description: 'In order to continue please register.',
        buttonTitle: 'Register',
        showOtherButtonTitle: 'Sign in',
        buttonPressed: () {},
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(builder: (_) => const LoginScreen());
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
