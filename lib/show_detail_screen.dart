import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/review.dart';
import 'package:tv_shows/show.dart';

class ShowDetailScreen extends StatefulWidget {
  final Show show;
  const ShowDetailScreen({Key? key, required this.show}) : super(key: key);

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Show show = widget.show;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          show.name,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(23, 0, 26, 0),
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Colors.white),
                          child: Image.asset(show.imageUrl))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(26, 20, 26, 0),
                      child: Text(
                        show.description,
                        style: const TextStyle(color: Colors.black, fontSize: 17),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(24, 25, 0, 0),
                      child: Text(
                        'Reviews',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
                      )),
                  ReviewList(show: show)
                ])))
      ]),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: ElevatedButton(
                child: const Text('Write a review', style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff52368c)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.5),
                    ))),
                onPressed: null,
              ))),
    );
  }
}

class ReviewList extends StatelessWidget {
  final Show show;
  const ReviewList({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
        create: ((context) => ReviewProvider()), child: _ReviewListWidget(show));
  }
}

class _ReviewListWidget extends StatelessWidget {
  final Show show;
  const _ReviewListWidget(this.show);

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewProvider>();
    final reviewsArray = reviews.reviews[show.name];

    if (reviewsArray!.isEmpty) {
      return const Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "No reviews yet.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff999999), fontSize: 17),
          ));
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
            child: Text(
              '${show.numOfReviews} REVIEWS, ${show.averageRating} AVERAGE',
              textAlign: TextAlign.start,
              style: const TextStyle(color: Color(0xff999999), fontSize: 14),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: RatingBarIndicator(
              itemBuilder: (context, _) => const Icon(
                IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                color: Color(0xff52368c),
              ),
              itemSize: 24,
              rating: show.averageRating,
              unratedColor: Color.lerp(Colors.white, const Color(0xff52368c), 0.3),
            )),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reviewsArray.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Image.asset(reviewsArray[index].imageUrl),
                      SizedBox(
                          width: 200,
                          child: Text(
                            reviewsArray[index].userEmail,
                            style: const TextStyle(color: Color(0xff52368c)),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          )),
                      Row(children: [
                        Text('${reviewsArray[index].rating}'),
                        const Icon(
                          IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                          color: Color(0xff52368c),
                        )
                      ])
                    ]),
                    if (reviewsArray[index].comment != null)
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                          child: Text(
                            reviewsArray[index].comment,
                            textAlign: TextAlign.start,
                          ))
                  ]));
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(
                  color: Color(0xffC8C7CC),
                  indent: 24,
                  endIndent: 24,
                ))
      ]);
    }
  }
}
