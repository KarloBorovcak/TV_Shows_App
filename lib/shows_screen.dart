import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tv_shows/gen/assets.gen.dart';
import 'package:tv_shows/show_list.dart';

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
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(100)))),
                    onPressed: () => setState(() => showsHidden = !showsHidden),
                    child: showsHidden
                        ? const Text('Show', style: TextStyle(color: Colors.blue))
                        : const Text('Hide', style: TextStyle(color: Colors.blue))))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Shows',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 36),
          )),
      backgroundColor: Colors.white,
      body: showsHidden
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.images.icShowsEmptyState.path),
                const Padding(
                    padding: EdgeInsets.all(26),
                    child: Text(
                      'Your shows are not showing. Get it?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff808080),
                      ),
                    ))
              ],
            )
          : const SingleChildScrollView(child: ShowList()),
    );
  }
}
