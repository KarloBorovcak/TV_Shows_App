import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_shows/utilities/auth_info.dart';

class StorageRepository {
  StorageRepository() {
    _storage = const FlutterSecureStorage();
  }
  AuthInfo? authInfo;
  late FlutterSecureStorage _storage;

  void setAuthInfo(AuthInfo authInfoSet) async {
    authInfo = authInfoSet;
    await _storage.write(key: 'accessToken', value: authInfo!.accessToken);
    await _storage.write(key: 'client', value: authInfo!.client);
    await _storage.write(key: 'tokenType', value: authInfo!.tokenType);
    await _storage.write(key: 'uid', value: authInfo!.uid);
  }

  Future<AuthInfo?> get getAuthInfo async {
    if (authInfo == null) {
      var accessToken = await _storage.read(key: 'accessToken');
      var client = await _storage.read(key: 'client');
      var tokenType = await _storage.read(key: 'tokenType');
      var uid = await _storage.read(key: 'uid');

      if (accessToken != null && client != null && tokenType != null && uid != null) {
        return AuthInfo(accessToken: accessToken, client: client, tokenType: tokenType, uid: uid);
      }
    }

    return authInfo;
  }
}
