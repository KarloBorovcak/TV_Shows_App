import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/screens/login/welcome_screen.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool emailNotEmpty = false;
  bool passwordNotEmpty = false;
  bool isHidden = true;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(() {
      final emailNotEmpty = emailController.text.isNotEmpty;

      setState(() => this.emailNotEmpty = emailNotEmpty);
    });

    passwordController.addListener(() {
      final passwordNotEmpty = passwordController.text.isNotEmpty;

      setState(() => this.passwordNotEmpty = passwordNotEmpty);
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900),
          textAlign: TextAlign.start,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'In order to continue please log in.',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(14),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          autocorrect: false,
          controller: emailController,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          autocorrect: false,
          obscureText: isHidden,
          controller: passwordController,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: isHidden
                  ? SvgPicture.asset(Assets.images.trailingIcon.path)
                  : SvgPicture.asset(Assets.images.trailingIconCrossed.path),
              onPressed: () => {setState(() => isHidden = !isHidden)},
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          child: Text('Login',
              style: TextStyle(
                  color: (emailNotEmpty && passwordNotEmpty)
                      ? const Color.fromRGBO(61, 29, 114, 1)
                      : const Color.fromRGBO(255, 255, 255, 0.8))),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color.fromRGBO(187, 187, 187, 0.8);
              } else {
                return Colors.white;
              }
            }),
            overlayColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(61, 29, 114, 0.3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.5),
              ),
            ),
          ),
          onPressed: (emailNotEmpty && passwordNotEmpty) ? () => goToNextScreen(context, emailController.text) : null,
        ),
      )
    ]);
  }

  void goToNextScreen(BuildContext context, String email) {
    final route = MaterialPageRoute(builder: (_) => WelcomeScreen(email: email));
    Navigator.of(context).push(route);
  }
}
