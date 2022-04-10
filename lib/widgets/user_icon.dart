import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key, this.url, this.size}) : super(key: key);

  final String? url;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Image.asset(
            Assets.images.icProfilePlaceholder.path,
            key: const ValueKey('placeholderAvatar'),
            height: size ?? 50,
            width: size ?? 50,
            fit: BoxFit.cover,
          )
        : CircleAvatar(
            radius: size ?? 25,
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(url!),
          );
  }
}
