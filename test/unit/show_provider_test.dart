import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/providers/show_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/utilities/request_state.dart';

import 'show_provider_test.mocks.dart';

@GenerateMocks([NetworkingRepository, Show])
void main() {
  test(
    'Show provider executes request successfully',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.fetchShows()).thenAnswer((_) async => <Show>[]);

      final ShowsProvider showProvider = ShowsProvider(networkingRepository);
      showProvider.fetchShows();

      await Future.delayed(const Duration(milliseconds: 10));
      expect(showProvider.state is RequestStateSuccess, true);
    },
  );

  test('Show provider executes request and catches error', () async {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.fetchShows()).thenThrow(Error());

    final ShowsProvider showProvider = ShowsProvider(networkingRepository);
    showProvider.fetchShows();

    await Future.delayed(const Duration(milliseconds: 10));
    expect(showProvider.state is RequestStateFailure, true);
  });

  test(
    'Show provider loading after executing a request',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.fetchShows()).thenAnswer((_) async => <Show>[]);

      final ShowsProvider showProvider = ShowsProvider(networkingRepository);
      showProvider.fetchShows();

      expect(showProvider.state is RequestStateLoading, true);
    },
  );

  test('Show provider fetch Show function stores list of Shows', () async {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.fetchShows()).thenAnswer((_) async => <Show>[MockShow()]);

    final ShowsProvider showProvider = ShowsProvider(networkingRepository);
    showProvider.fetchShows();

    await Future.delayed(const Duration(milliseconds: 10));
    expect(showProvider.showCount, 1);
  });

  test('Show provider executes request in constructor', () {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.fetchShows()).thenAnswer((_) async => <Show>[MockShow()]);

    ShowsProvider(networkingRepository);

    verify(networkingRepository.fetchShows()).called(1);
  });
}
