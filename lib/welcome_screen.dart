import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  final String email;

  const WelcomeScreen({Key? key, required this.email}) : super(key: key);
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
                  child: Text('Welcome, $email!',
                      style: const TextStyle(color: Color.fromRGBO(128, 128, 128, 1), fontSize: 17)))
            ],
          ),
        ));
  }
}
