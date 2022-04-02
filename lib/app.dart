import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/screens/login/login_screen.dart';
import 'package:tv_shows/screens/shows/shows_screen.dart';
import 'package:tv_shows/utilities/storage_repository.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

class TvShowsApp extends StatelessWidget {
  const TvShowsApp({Key? key, this.storage}) : super(key: key);
  final StorageRepository? storage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => storage ?? StorageRepository(),
        ),
        Provider(
          create: (context) => NetworkingRepository(context.read<StorageRepository>()),
        ),
      ],
      child: MaterialApp(
          home: storage == null
              ? const Scaffold(
                  body: LoginScreen(),
                  backgroundColor: Color(0xff3d1d72),
                )
              : const ShowsScreen()),
    );
  }
}
