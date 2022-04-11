import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class LoginUI extends StatefulWidget {
  final String title;
  final String description;
  final String buttonTitle;
  final bool isLoading;
  final String showOtherButtonTitle; // Will be used for: "Create account" / "Sing in"
  final Function(String email, String password) buttonPressed;
  final VoidCallback showOtherButtonPressed;

  const LoginUI(
      {Key? key,
      required this.title,
      required this.description,
      required this.buttonTitle,
      required this.isLoading,
      required this.showOtherButtonTitle,
      required this.buttonPressed,
      required this.showOtherButtonPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  bool isHidden = true;
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900),
          textAlign: TextAlign.start,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          widget.description,
          style: const TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(14),
        child: TextField(
          key: const ValueKey('emailTextField'),
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.white),
          autocorrect: false,
          onChanged: (value) => setState(() => email = value),
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: TextField(
          key: const ValueKey('passwordTextField'),
          textInputAction: TextInputAction.done,
          style: const TextStyle(color: Colors.white),
          autocorrect: false,
          obscureText: isHidden,
          onChanged: (value) => setState(() => password = value),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: isHidden
                  ? SvgPicture.asset(Assets.images.trailingIcon.path)
                  : SvgPicture.asset(Assets.images.trailingIconCrossed.path),
              onPressed: () => setState(() => isHidden = !isHidden),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 70),
        child: TextButton(
            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
            onPressed: widget.showOtherButtonPressed,
            child: Text(
              widget.showOtherButtonTitle,
              style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          child: widget.isLoading
              ? const CircularProgressIndicator(
                  color: Color(0xff3d1d72),
                )
              : Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      color: (email.isNotEmpty && password.isNotEmpty)
                          ? const Color(0xff3d1d72)
                          : const Color(0xCCFFFFFF)),
                ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0xCCBBBBBB);
              } else {
                return Colors.white;
              }
            }),
            overlayColor: MaterialStateProperty.all<Color>(const Color(0xff3d1d72)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.5),
              ),
            ),
          ),
          onPressed: (email.isNotEmpty && password.isNotEmpty)
              ? () => Future.delayed(Duration.zero, (() => widget.buttonPressed(email, password)))
              : null,
        ),
      )
    ]);
  }
}
