import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tv_shows/utilities/auth_info.dart';

import '../models/user.dart';

const _accessToken = 'accessToken';

class StorageRepository {
  static Future<void> initialize() async {
    await Hive.initFlutter();
  }

  final _box = Hive.openBox<String>('userJsonBox');

  Future<void> storeJson(Map<String, dynamic> json, String key) async {
    final box = await _box;
    await box.put(key, jsonEncode(json));
    user = User.fromJson(json);
  }

  Future<Map<String, dynamic>?> readJson(String key) async {
    final box = await _box;
    final json = box.get(key);
    if (json == null) {
      return null;
    }
    user = User.fromJson(jsonDecode(json));
    return jsonDecode(json);
  }

  StorageRepository() {
    _storage = const FlutterSecureStorage();
  }
  AuthInfo? authInfo;
  late FlutterSecureStorage _storage;
  late User user;

  User get getUser {
    return user;
  }

  void setAuthInfo(AuthInfo authInfoSet) async {
    authInfo = authInfoSet;
    await _storage.write(key: 'accessToken', value: authInfo!.accessToken);
    await _storage.write(key: 'client', value: authInfo!.client);
    await _storage.write(key: 'tokenType', value: authInfo!.tokenType);
    await _storage.write(key: 'uid', value: authInfo!.uid);
  }

  Future<AuthInfo?> get getAuthInfo async {
    if (authInfo == null) {
      var accessToken = await _storage.read(key: _accessToken);
      var client = await _storage.read(key: 'client');
      var tokenType = await _storage.read(key: 'tokenType');
      var uid = await _storage.read(key: 'uid');

      if (accessToken != null && client != null && tokenType != null && uid != null) {
        return AuthInfo(accessToken: accessToken, client: client, tokenType: tokenType, uid: uid);
      }
    }

    return authInfo;
  }

  void deleteData() async {
    await _storage.deleteAll();
    final box = await _box;
    await box.delete('user');
  }
}
