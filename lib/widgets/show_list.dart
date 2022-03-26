import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/screens/shows/show_detail_screen.dart';
import 'package:tv_shows/utilities/networking_repository.dart';

import '../providers/show_provider.dart';

class ShowList extends StatelessWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShowsProvider>(
      create: ((context) => ShowsProvider(context.read<NetworkingRepository>())),
      child: _ShowListWidget(),
    );
  }
}

class _ShowListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shows = context.watch<ShowsProvider>();
    final showArray = shows.showGetShows;
    return ListView.builder(
        itemCount: shows.showCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ShowDetailScreen(show: showArray[index]))),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white, boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  )
                ]),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Image.asset(
                    showArray[index].imageUrl,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Text(showArray[index].title,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
                    child: Text(
                      showArray[index].description,
                      style: const TextStyle(color: Color(0x99000000), fontSize: 14, height: 1.6),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
