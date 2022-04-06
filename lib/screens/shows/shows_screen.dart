import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/screens/shows/user_profile_screen.dart';
import 'package:tv_shows/utilities/storage_repository.dart';
import 'package:tv_shows/widgets/show_card.dart';
import 'package:tv_shows/widgets/user_icon.dart';

import '../../providers/show_provider.dart';
import '../../utilities/networking_repository.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowsProvider>(
      create: ((context) => ShowsProvider(context.read<NetworkingRepository>())),
      child: Consumer<ShowsProvider>(
        builder: (context, provider, _) => provider.state.maybeWhen(
            orElse: () => const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Expanded(
                      child: CircularProgressIndicator(color: Color(0xff3d1d72)),
                    ),
                  ),
                ),
            success: (result) => _Showscreen(),
            failure: (error) => Builder(builder: (context) => Text(error.toString()))),
      ),
    );
  }
}

class _Showscreen extends StatefulWidget {
  @override
  State<_Showscreen> createState() => _ShowscreenState();
}

class _ShowscreenState extends State<_Showscreen> {
  @override
  Widget build(BuildContext context) {
    final shows = context.watch<ShowsProvider>();
    final showArray = shows.showGetShows;
    final storage = context.read<StorageRepository>();
    var iconUrl = storage.getUser.imageUrl;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: IconButton(
              onPressed: () async {
                var imagePath = await showModalBottomSheet(
                  context: context,
                  builder: (_) => UserProfileScreen(
                    repository: context.read<NetworkingRepository>(),
                    storage: context.read<StorageRepository>(),
                  ),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                );
                setState(() {
                  iconUrl = imagePath;
                });
              },
              icon: UserIcon(url: iconUrl),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Shows',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 36),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: shows.showCount,
        itemBuilder: (context, index) {
          return ShowCard(
            showArray: showArray,
            index: index,
          );
        },
      ),
    );
  }
}
