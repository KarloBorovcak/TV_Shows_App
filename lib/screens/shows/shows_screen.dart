import 'package:flutter/material.dart';
import 'package:tv_shows/widgets/no_shows.dart';
import 'package:tv_shows/widgets/show_list.dart';
import 'package:tv_shows/widgets/user_icon.dart';

class ShowsScreen extends StatefulWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  bool showsHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
            child: IconButton(
              onPressed: () => null,
              icon: const UserIcon(),
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
      body: showsHidden ? const NoShows() : const ShowList(),
    );
  }
}
