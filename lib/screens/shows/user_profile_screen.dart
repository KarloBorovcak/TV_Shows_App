import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/provider_listener.dart';
import 'package:tv_shows/providers/user_profile_provider.dart';
import 'package:tv_shows/screens/login/login_screen.dart';
import 'package:tv_shows/screens/shows/shows_screen.dart';
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
            success: (result) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShowsScreen()));
                        },
                        child: const Text("Ok"))
                  ],
                  title: const Text('Success'),
                  content: const Text("Profile has been updated!"),
                );
              },
            ),
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

class __UserProfileScreenState extends State<_UserProfileScreen> {
  TextEditingController controller = TextEditingController();
  String? iconUrl;
  bool selecting = false;
  File? imageFileHolder;

  @override
  void initState() {
    controller.text = widget.user.email;
    iconUrl = widget.user.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProfileProvider>();

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
                  icon: selecting
                      ? CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: Image.file(
                            File(iconUrl!),
                            fit: BoxFit.cover,
                          ).image)
                      : UserIcon(
                          url: iconUrl,
                          size: 95,
                        ),
                  onPressed: () async {
                    final picker = ImagePicker();
                    var imageXFile = await picker.pickImage(source: ImageSource.gallery);
                    if (imageXFile == null) return;
                    final imageFile = File(imageXFile.path);
                    setState(() {
                      selecting = true;
                      iconUrl = imageFile.path;
                      imageFileHolder = imageFile;
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
                if (controller.text != widget.user.email && !selecting) {
                  provider.updateUserEmail(controller.text);
                }
                if (selecting && controller.text == widget.user.email) {
                  provider.updateUser(null, imageFileHolder!);
                }
                if (selecting && controller.text != widget.user.email) {
                  provider.updateUser(controller.text, imageFileHolder!);
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
