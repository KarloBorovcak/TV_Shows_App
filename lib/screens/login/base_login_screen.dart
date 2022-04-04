import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/widgets/login_ui.dart';

class BaseLoginScreen extends StatefulWidget {
  final String title;
  final String description;
  final String buttonTitle;
  final bool isLoading;
  final String showOtherButtonTitle; // Will be used for: "Create account" / "Sing in"
  final Function(String email, String password) buttonPressed;
  final VoidCallback showOtherButtonPressed;

  const BaseLoginScreen(
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
  State<BaseLoginScreen> createState() => _BaseLoginScreenState();
}

class _BaseLoginScreenState extends State<BaseLoginScreen> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.25),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                      child: SvgPicture.asset(Assets.images.topLeftIllustration.path),
                      left: 0,
                      top: 0,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: SvgPicture.asset(Assets.images.topRightIllustration.path),
                    ),
                    Positioned(
                      child: SlideTransition(
                        position: _animation,
                        child: SvgPicture.asset(Assets.images.logoHorizontalWhite.path),
                      ),
                      top: 180,
                      left: 40,
                    ),
                  ],
                ),
              ),
              LoginUI(
                  title: widget.title,
                  description: widget.description,
                  buttonTitle: widget.buttonTitle,
                  isLoading: widget.isLoading,
                  showOtherButtonTitle: widget.showOtherButtonTitle,
                  buttonPressed: widget.buttonPressed,
                  showOtherButtonPressed: widget.showOtherButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}
