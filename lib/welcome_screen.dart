import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tv_shows/shows_screen.dart';
import 'gen/assets.gen.dart';

class WelcomeScreen extends StatefulWidget {
  final String email;
  const WelcomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ShowsScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.images.welcomeIcon.path),
              Padding(
                  padding: const EdgeInsets.all(31),
                  child: Text('Welocme, ${widget.email}!',
                      style: const TextStyle(color: Color.fromRGBO(128, 128, 128, 1), fontSize: 17)))
            ],
          ),
        ));
  }
}
