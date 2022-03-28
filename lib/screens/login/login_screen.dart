import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/signin_info.dart';
import 'package:tv_shows/providers/login_provider.dart';
import 'package:tv_shows/screens/login/base_login_screen.dart';
import 'package:tv_shows/screens/login/welcome_screen.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../../providers/provider_listener.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(context.read<NetworkingRepository>()),
      child: ConsumerListener<LoginProvider>(
        builder: (context, provider) => const _LoginScreen(),
        listener: (context, provider) {
          provider.state.whenOrNull(
            success: (result) => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen(email: result.email))),
            failure: (error) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Dismiss"))
                  ],
                  title: const Text('Error'),
                  content: Text(error.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: BaseLoginScreen(
        title: 'Login',
        description: 'In order to continue please log in.',
        buttonTitle: 'Login',
        isLoading: provider.state.maybeWhen(orElse: () => false, loading: () => true),
        showOtherButtonTitle: 'Create account',
        buttonPressed: (email, password) {
          provider.didSelectLoginUser(SignInInfo(email, password));
        },
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(builder: (_) => const RegisterScreen());
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
