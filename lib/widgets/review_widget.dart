import 'package:flutter/material.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/widgets/user_icon.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          UserIcon(url: review.user.imageUrl),
          SizedBox(
            width: 200,
            child: Text(
              review.user.email,
              style: const TextStyle(color: Color(0xff52368c)),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Row(children: [
            Text('${review.rating}'),
            const Icon(
              IconData(0xe5f9, fontFamily: 'MaterialIcons'),
              color: Color(0xff52368c),
            )
          ])
        ]),
        if (review.comment != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
            child: Text(
              review.comment!,
              textAlign: TextAlign.start,
            ),
          )
      ]),
    );
  }
}
