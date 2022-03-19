import 'package:flutter/material.dart';

import 'login_screen.dart';

class TvShowsApp extends StatelessWidget {
  const TvShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: LoginScreen(), backgroundColor: Color.fromRGBO(61, 29, 114, 1)));
  }
}
