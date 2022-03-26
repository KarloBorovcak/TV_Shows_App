import 'package:tv_shows/models/register_info.dart';
import 'package:tv_shows/providers/request_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../models/user.dart';

class RegisterProvider extends RequestProvider<User> {
  RegisterProvider(this._repository);
  final NetworkingRepository _repository;

  void didSelectRegisterUser(RegisterInfo registerInfo) {
    executeRequest(requestBuilder: () => _repository.registerUser(registerInfo));
  }
}
