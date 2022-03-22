import 'package:flutter/material.dart';

import '../models/review.dart';

class ReviewProvider extends ChangeNotifier {
  Map<String, List> get reviews => Review.allReviews;
  int get reviewCount => Review.allReviews.length;
}
