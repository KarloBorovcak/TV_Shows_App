import 'package:flutter/material.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../models/review.dart';

class ReviewProvider extends ChangeNotifier {
  ReviewProvider(NetworkingRepository _repository, int id) {
    reviewList = _repository.fetchReviews(id) as List<Review>;
  }

  late List<Review> reviewList;

  List<Review> get reviews => reviewList;
  int get reviewCount => reviewList.length;
}
