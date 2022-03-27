import 'package:tv_shows/providers/request_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../models/review.dart';

class ReviewProvider extends RequestProvider<List<Review>> {
  ReviewProvider(this._repository, String id) {
    fetchReviews(id);
  }

  final NetworkingRepository _repository;
  List<Review> reviewList = [];

  List<Review> get reviews => reviewList;
  int get reviewCount => reviewList.length;

  void fetchReviews(String id) async {
    executeRequest(requestBuilder: () async => reviewList = await _repository.fetchReviews(id));
  }
}
