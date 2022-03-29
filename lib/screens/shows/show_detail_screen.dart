import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/utilities/networking_repository.dart';
import 'package:tv_shows/widgets/review_widget.dart';

import '../../providers/review_provider.dart';

class ShowDetailScreen extends StatelessWidget {
  final Show show;
  const ShowDetailScreen({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
      create: ((context) => ReviewProvider(context.read<NetworkingRepository>(), show.id)),
      child: Consumer<ReviewProvider>(
        builder: (context, provider, _) => provider.state.when(
            initial: () => const Center(
                  child: Expanded(
                    child: CircularProgressIndicator(color: Color(0xff3d1d72)),
                  ),
                ),
            success: (result) => _ShowDetailScreen(show: show),
            loading: () => const Center(
                  child: Expanded(
                    child: CircularProgressIndicator(
                      color: Color(0xff3d1d72),
                    ),
                  ),
                ),
            failure: (error) => Builder(builder: (context) => Text(error.toString()))),
      ),
    );
  }
}

class _ShowDetailScreen extends StatelessWidget {
  const _ShowDetailScreen({Key? key, required this.show}) : super(key: key);
  final Show show;

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewProvider>();
    final reviewsArray = reviews.reviewList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                show.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
              ),
              background: Image.network(show.imageUrl, fit: BoxFit.fill),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 20, 26, 0),
              child: Text(
                show.description,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 25, 0, 0),
              child: Text(
                'Reviews',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
              child: Text(
                '${show.noOfReviews} REVIEWS, ${show.averageRating} AVERAGE',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Color(0xff999999), fontSize: 14),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: RatingBarIndicator(
                itemBuilder: (context, _) => const Icon(
                  IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                  color: Color(0xff52368c),
                ),
                itemSize: 24,
                rating: show.averageRating,
                unratedColor: Color.lerp(Colors.white, const Color(0xff52368c), 0.3),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  ReviewWidget(review: reviewsArray[index]),
                  if (index != reviewsArray.length - 1)
                    const Divider(
                      color: Color(0xffC8C7CC),
                      indent: 24,
                      endIndent: 24,
                    )
                ],
              );
            }, childCount: reviewsArray.length),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ElevatedButton(
            child: const Text('Write a review', style: TextStyle(color: Colors.white)),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xff52368c)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21.5),
                ),
              ),
            ),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
