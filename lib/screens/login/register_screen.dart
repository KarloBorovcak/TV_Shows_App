import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/register_info.dart';
import 'package:tv_shows/providers/provider_listener.dart';
import 'package:tv_shows/providers/register_provider.dart';
import 'package:tv_shows/screens/login/base_login_screen.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(context.read<NetworkingRepository>()),
      child: ConsumerListener<RegisterProvider>(
        builder: ((context, provider) => const _RegisterScreen()),
        listener: (context, provider) {
          provider.state.whenOrNull(
            success: (result) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"))
                  ],
                  title: const Text('Success'),
                  content: Text("User ${result.email} successfully registered!"),
                );
              },
            ),
            failure: (error) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Dissmis"))
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

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();

    return Scaffold(
      backgroundColor: const Color(0xff3d1d72),
      body: BaseLoginScreen(
        title: 'Register',
        description: 'In order to continue please register.',
        buttonTitle: 'Register',
        isLoading: provider.state.maybeWhen(orElse: () => false, loading: () => true),
        showOtherButtonTitle: 'Sign in',
        buttonPressed: (email, password) => provider.didSelectRegisterUser(RegisterInfo(email, password, password)),
        showOtherButtonPressed: () {
          final route = MaterialPageRoute(builder: (_) => const LoginScreen());
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }
}
