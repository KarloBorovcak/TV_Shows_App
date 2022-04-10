import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:tv_shows/screens/shows/shows_screen.dart';
import '../../gen/assets.gen.dart';
import '/gen/assets.gen.dart';

class WelcomeScreen extends StatefulWidget {
  final String email;
  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ShowsScreen())));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(Assets.images.welcomeIcon.path),
            Padding(
              padding: const EdgeInsets.all(31),
              child: Text(
                'Welcome, ${widget.email}!',
                style: const TextStyle(color: Color.fromRGBO(128, 128, 128, 1), fontSize: 17),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 300,
                width: 250,
                child: Lottie.asset('assets/animations/welcome.json', animate: true, repeat: false, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
