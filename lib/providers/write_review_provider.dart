import 'package:tv_shows/models/submit_review.dart';
import 'package:tv_shows/providers/request_provider.dart';
import 'package:tv_shows/providers/review_provider.dart';

import '../utilities/networking_repository.dart';

class WriteReviewProvider extends RequestProvider<void> {
  WriteReviewProvider(this._repository, this.provider);

  final NetworkingRepository _repository;
  final ReviewProvider provider;

  void writeReview(SubmitReview review, int id) {
    executeRequest(requestBuilder: () async => _repository.submitReview(review));
    provider.fetchReviews(id.toString());
  }
}
