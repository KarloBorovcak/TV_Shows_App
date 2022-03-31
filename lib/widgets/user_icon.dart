import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key, this.url}) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Image.asset(
            Assets.images.icProfilePlaceholder.path,
            height: 50,
            width: 50,
          )
        : CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(url!),
          );
  }
}
