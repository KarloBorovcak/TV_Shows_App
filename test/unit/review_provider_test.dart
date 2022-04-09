import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/providers/review_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/utilities/request_state.dart';

import 'review_provider_test.mocks.dart';

@GenerateMocks([NetworkingRepository, Review])
void main() {
  test(
    'Review provider executes request successfully',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.fetchReviews(any)).thenAnswer((_) async => <Review>[]);

      final ReviewProvider reviewProvider = ReviewProvider(networkingRepository, '');
      reviewProvider.fetchReviews('');

      await Future.delayed(const Duration(milliseconds: 10));
      expect(reviewProvider.state is RequestStateSuccess, true);
    },
  );

  test('Review provider executes request and catches error', () async {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.fetchReviews(any)).thenThrow(Error());

    final ReviewProvider reviewProvider = ReviewProvider(networkingRepository, '');
    reviewProvider.fetchReviews('');

    await Future.delayed(const Duration(milliseconds: 10));
    expect(reviewProvider.state is RequestStateFailure, true);
  });

  test(
    'Review provider loading after executing a request',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.fetchReviews(any)).thenAnswer((_) async => <Review>[]);

      final ReviewProvider reviewProvider = ReviewProvider(networkingRepository, '');
      reviewProvider.fetchReviews('');

      expect(reviewProvider.state is RequestStateLoading, true);
    },
  );

  test('Review provider fetch review function stores list of reviews', () async {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.fetchReviews(any)).thenAnswer((_) async => <Review>[MockReview()]);

    final ReviewProvider reviewProvider = ReviewProvider(networkingRepository, '');
    reviewProvider.fetchReviews('');

    await Future.delayed(const Duration(milliseconds: 10));
    expect(reviewProvider.reviewCount, 1);
  });
}
