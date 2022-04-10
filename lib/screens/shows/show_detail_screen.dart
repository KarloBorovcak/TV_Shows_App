import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/screens/shows/write_review_screen.dart';
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
            initial: () => ShowDetailScreenWidget(
                show: show, widget: const Center(child: CircularProgressIndicator(color: Color(0xff52368c)))),
            loading: () => ShowDetailScreenWidget(
                show: show, widget: const Center(child: CircularProgressIndicator(color: Color(0xff52368c)))),
            success: (result) => ShowDetailScreenWidget(show: show, widget: null),
            failure: (error) => ShowDetailScreenWidget(show: show, widget: Text(error.toString()))),
      ),
    );
  }
}

class ShowDetailScreenWidget extends StatefulWidget {
  const ShowDetailScreenWidget({Key? key, required this.show, required this.widget}) : super(key: key);
  final Show show;
  final Widget? widget;

  @override
  State<ShowDetailScreenWidget> createState() => ShowDetailScreenWidgetState();
}

class ShowDetailScreenWidgetState extends State<ShowDetailScreenWidget> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> opacity;
  late final Animation<double> opacityReviews;
  late final Animation<Offset> slideRight;
  late final Animation<Offset> slideDown;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    opacity = CurvedAnimation(parent: controller, curve: const Interval(0, 0.4)).drive(Tween<double>(begin: 0, end: 1));

    opacityReviews =
        CurvedAnimation(parent: controller, curve: const Interval(0.3, 0.7)).drive(Tween<double>(begin: 0, end: 1));

    slideRight = CurvedAnimation(parent: controller, curve: const Interval(0, 0.4))
        .drive(Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero));

    slideDown = CurvedAnimation(parent: controller, curve: const Interval(0.6, 1))
        .drive(Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero));

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = context.watch<ReviewProvider>();
    final reviewsArray = reviews.reviewList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.show.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),
              ),
              background: Hero(
                tag: widget.show.id,
                child: CachedNetworkImage(imageUrl: widget.show.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverFadeTransition(
            opacity: opacity,
            sliver: SliverToBoxAdapter(
              child: SlideTransition(
                position: slideRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 20, 26, 0),
                  child: Text(
                    widget.show.description,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
          SliverFadeTransition(
            opacity: opacityReviews,
            sliver: SliverToBoxAdapter(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 25, 0, 0),
                  child: Text(
                    'Reviews',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
                  child: Text(
                    '${widget.show.noOfReviews} REVIEWS, ${widget.show.averageRating} AVERAGE',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Color(0xff999999), fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: RatingBarIndicator(
                    itemBuilder: (context, _) => const Icon(
                      IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                      color: Color(0xff52368c),
                    ),
                    itemSize: 24,
                    rating: widget.show.averageRating,
                    unratedColor: Color.lerp(Colors.white, const Color(0xff52368c), 0.3),
                  ),
                ),
              ]),
            ),
          ),
          widget.widget == null
              ? SliverFadeTransition(
                  opacity: opacityReviews,
                  sliver: SliverList(
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
                )
              : SliverFadeTransition(opacity: opacityReviews, sliver: SliverToBoxAdapter(child: widget.widget))
        ],
      ),
      bottomNavigationBar: SlideTransition(
        position: slideDown,
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => ChangeNotifierProvider<ReviewProvider>.value(
                      value: context.read<ReviewProvider>(), child: WriteReviewScreen(showId: widget.show.id)),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
