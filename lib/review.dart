import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class ReviewProvider extends ChangeNotifier {}

class Review {
  String comment;
  int rating;
  String userEmail;
  String imageUrl;
  static final allReviews = [
    Review('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 3, 'netko@gmail.com',
        Assets.images.icProfilePlaceholder.path),
    Review('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 1, 'netko@gmail.com',
        Assets.images.icProfilePlaceholder.path),
    Review('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 5, 'netko@gmail.com',
        Assets.images.icProfilePlaceholder.path)
  ];

  Review(this.comment, this.rating, this.userEmail, this.imageUrl);
}
