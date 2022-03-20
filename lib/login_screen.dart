import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tv_shows/login_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Stack(
                  children: [
                    Positioned(
                      child: SvgPicture.asset('./assets/images/Top_left_illustration.svg', fit: BoxFit.contain),
                      left: 0,
                      top: 0,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: SvgPicture.asset('./assets/images/Top_right_illustration.svg', fit: BoxFit.contain),
                    ),
                    Positioned(
                      child: SvgPicture.asset('./assets/images/Logo_Horizontal_White.svg', fit: BoxFit.contain),
                      top: 180,
                      left: 40,
                    )
                  ],
                )),
                const LoginUI(),
              ],
            ))));
  }
}
