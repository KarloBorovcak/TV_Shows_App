import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/screens/login/login_screen.dart';
import 'package:tv_shows/utilities/auth_info_holder.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

class TvShowsApp extends StatelessWidget {
  const TvShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => AuthInfoHolder(),
        ),
        Provider(
          create: (context) => NetworkingRepository(context.watch<AuthInfoHolder>()),
        )
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: LoginScreen(),
          backgroundColor: Color(0xff52368c),
        ),
      ),
    );
  }
}
