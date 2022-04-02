import 'package:tv_shows/providers/request_provider.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/utilities/storage_repository.dart';

import '../models/user.dart';

class UserProfileProvider extends RequestProvider<void> {
  UserProfileProvider(this._repository, this._storage);

  final NetworkingRepository _repository;
  final StorageRepository _storage;

  User get getUser {
    return _storage.getUser;
  }
}
