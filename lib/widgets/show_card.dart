import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/screens/shows/show_detail_screen.dart';

class ShowCard extends StatelessWidget {
  const ShowCard({
    Key? key,
    required this.showArray,
    required this.index,
  }) : super(key: key);

  final List<Show> showArray;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: InkWell(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShowDetailScreen(show: showArray[index]))),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white, boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            )
          ]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 190,
              width: 340,
              child: CachedNetworkImage(
                imageUrl: showArray[index].imageUrl,
                fit: BoxFit.cover,
              ),
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
  }
}
