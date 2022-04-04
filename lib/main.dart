import 'package:flutter/material.dart';
import 'package:tv_shows/app.dart';
import 'package:tv_shows/utilities/storage_repository.dart';

void main() async {
  await StorageRepository.initialize();
  StorageRepository? storage = StorageRepository();
  var authInfo = await storage.getAuthInfo;
  var user = await storage.readJson('user');
  if (user == null || authInfo == null) {
    storage = null;
  }

  runApp(TvShowsApp(storage: storage));
}
