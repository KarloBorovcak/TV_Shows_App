import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void checkDisabled() {
    if (emailController.text == "" && passwordController.text == "") null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: TextField(
            autocorrect: false,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
          ),
        ),
        Container(
          child: TextField(
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
          ),
        ),
        Container(
          child: OutlinedButton(
            child: const Text('Login'),
            onPressed: checkDisabled,
          ),
        )
      ],
    );
  }
}
