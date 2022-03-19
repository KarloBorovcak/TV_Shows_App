import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Positioned(
              child: SvgPicture.asset('./assets/images/Top_left_illustration.svg'),
            ),
            Positioned(
              left: 0,
              child: SvgPicture.asset('./assets/images/Top_right_illustration.svg'),
            ),
            SvgPicture.asset('./assets/images/Logo_Horizontal_White.svg')
          ],
        ),
        const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 34),
          textAlign: TextAlign.start,
        ),
        const Text(
          'In order to continue please log in.',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        TextField(
          style: const TextStyle(color: Colors.white),
          autocorrect: false,
          controller: emailController,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        TextField(
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
                    ? SvgPicture.asset('./assets/images/Trailing_Icon.svg')
                    : SvgPicture.asset('./assets/images/Trailing_Icon_crossed.svg'),
                onPressed: () => {setState(() => isHidden = !isHidden)},
              )),
        ),
        ElevatedButton(
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
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.5),
              ))),
          onPressed: (emailNotEmpty && passwordNotEmpty) ? () {} : null,
        )
      ],
    );
  }
}
