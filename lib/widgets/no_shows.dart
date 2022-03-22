import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../gen/assets.gen.dart';

class NoShows extends StatelessWidget {
  const NoShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.images.icShowsEmptyState.path),
        const Padding(
          padding: EdgeInsets.all(26),
          child: Text(
            'Your shows are not showing. Get it?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff808080),
            ),
          ),
        )
      ],
    );
  }
}
