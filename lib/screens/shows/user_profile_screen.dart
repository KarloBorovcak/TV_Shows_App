import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/update_user.dart';
import 'package:tv_shows/providers/provider_listener.dart';
import 'package:tv_shows/providers/user_profile_provider.dart';
import 'package:tv_shows/screens/login/login_screen.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/utilities/storage_repository.dart';
import 'package:tv_shows/widgets/user_icon.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key, required this.repository, required this.storage}) : super(key: key);

  final StorageRepository storage;
  final NetworkingRepository repository;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfileProvider(repository, storage),
      child: ConsumerListener<UserProfileProvider>(
        builder: (context, provider) => _UserProfileScreen(user: provider.getUser),
        listener: (context, provider) {
          provider.state.whenOrNull(
            failure: (error) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Dismiss"))
                  ],
                  title: const Text('Error'),
                  content: Text(error.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _UserProfileScreen extends StatefulWidget {
  const _UserProfileScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<_UserProfileScreen> createState() => __UserProfileScreenState();
}

class __UserProfileScreenState extends State<_UserProfileScreen> with TickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late AnimationController animationRotationController;
  late AnimationController animationScaleController;
  late Animation<double> rotate;
  late Animation<double> scale;
  String? iconUrl;
  bool selecting = false;

  @override
  void initState() {
    animationRotationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animationScaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    rotate = CurvedAnimation(parent: animationRotationController, curve: Curves.linear);
    scale = CurvedAnimation(parent: animationScaleController, curve: Curves.easeIn)
        .drive(Tween<double>(begin: 0, end: 1.2));
    controller.text = widget.user.email;
    iconUrl = widget.user.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationRotationController.dispose();
    animationScaleController.dispose();
    super.dispose();
  }

  void rotateImage() async {
    await animationRotationController.forward();
    animationRotationController.reset();
  }

  void scaleImage() async {
    await animationScaleController.forward();
    await animationScaleController.reverse();
    animationScaleController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProfileProvider>();

    provider.state.whenOrNull(success: (result) {
      scaleImage();
      Future.delayed(const Duration(milliseconds: 600), () => Navigator.of(context).pop(iconUrl));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: const Color(0xff52368c))),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 95,
                  icon: provider.state.maybeWhen(
                    success: (result) => selecting
                        ? ScaleTransition(
                            scale: scale,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                backgroundImage: Image.file(
                                  File(iconUrl!),
                                  fit: BoxFit.cover,
                                ).image),
                          )
                        : ScaleTransition(
                            scale: scale,
                            child: UserIcon(
                              url: iconUrl,
                              size: 95,
                            ),
                          ),
                    orElse: () => selecting
                        ? RotationTransition(
                            turns: rotate,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                backgroundImage: Image.file(
                                  File(iconUrl!),
                                  fit: BoxFit.cover,
                                ).image))
                        : UserIcon(
                            url: iconUrl,
                            size: 95,
                          ),
                  ),
                  onPressed: () async {
                    final picker = ImagePicker();
                    var imageXFile = await picker.pickImage(source: ImageSource.gallery);
                    if (imageXFile == null) return;
                    rotateImage();
                    setState(() {
                      selecting = true;
                      iconUrl = imageXFile.path;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff3d1d72))),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff3d1d72))),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xff3d1d72))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 5),
            child: ElevatedButton(
              child: provider.state.maybeWhen(
                  orElse: (() => const Text('Update', style: TextStyle(color: Color(0xff52368c)))),
                  loading: () => const CircularProgressIndicator(color: Color(0xff52368c))),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xff52368c), width: 1.5),
                    borderRadius: BorderRadius.circular(21.5),
                  ),
                ),
              ),
              onPressed: () {
                if (controller.text != widget.user.email || selecting) {
                  provider.updateUser(UpdateUser(controller.text, selecting ? iconUrl : null));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, MediaQuery.of(context).viewInsets.bottom + 10),
            child: ElevatedButton(
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff52368c)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.5),
                  ),
                ),
              ),
              onPressed: () {
                context.read<StorageRepository>().deleteData();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
