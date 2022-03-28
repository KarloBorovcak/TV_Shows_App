import 'package:tv_shows/models/signin_info.dart';
import 'package:tv_shows/providers/request_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../models/user.dart';

class LoginProvider extends RequestProvider<User> {
  LoginProvider(this._repository);
  final NetworkingRepository _repository;

  void didSelectLoginUser(SignInInfo signInInfo) {
    executeRequest(requestBuilder: () => _repository.signInUser(signInInfo));
  }
}
