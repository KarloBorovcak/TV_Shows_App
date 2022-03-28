import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(url),
    );
  }
}
