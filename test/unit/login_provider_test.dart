import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/models/signin_info.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/providers/login_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/utilities/request_state.dart';

import 'login_provider_test.mocks.dart';

@GenerateMocks([NetworkingRepository, User, SignInInfo])
void main() {
  test(
    'Login provider executes request successfully',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.signInUser(any)).thenAnswer((_) async => MockUser());

      final LoginProvider loginProvider = LoginProvider(networkingRepository);
      loginProvider.didSelectLoginUser(MockSignInInfo());

      await Future.delayed(const Duration(milliseconds: 10));
      expect(loginProvider.state is RequestStateSuccess, true);
    },
  );

  test('Login provider executes request and catches error', () async {
    final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
    when(networkingRepository.signInUser(any)).thenThrow(Error());

    final LoginProvider loginProvider = LoginProvider(networkingRepository);
    loginProvider.didSelectLoginUser(MockSignInInfo());

    expect(loginProvider.state is RequestStateFailure, true);
  });

  test(
    'Login provider loading after executing a request',
    () async {
      final MockNetworkingRepository networkingRepository = MockNetworkingRepository();
      when(networkingRepository.signInUser(any)).thenAnswer((_) async => MockUser());

      final LoginProvider loginProvider = LoginProvider(networkingRepository);
      loginProvider.didSelectLoginUser(MockSignInInfo());

      expect(loginProvider.state is RequestStateLoading, true);
    },
  );
}
