import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/submit_review.dart';
import 'package:tv_shows/providers/review_provider.dart';
import 'package:tv_shows/providers/write_review_provider.dart';

import '../providers/provider_listener.dart';
import '../utilities/networking_repository.dart';

class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({Key? key, required this.showId}) : super(key: key);
  final String showId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteReviewProvider(
        context.read<NetworkingRepository>(),
        context.read<ReviewProvider>(),
      ),
      child: ConsumerListener<WriteReviewProvider>(
        builder: (context, provider) => _WriteReviewScreen(
          showId: int.parse(showId),
          isLoading: provider.state.maybeWhen(orElse: () => false, loading: () => true),
        ),
        listener: (context, provider) {
          provider.state.whenOrNull(
            success: (result) => Navigator.of(context).pop(),
            failure: (error) => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Dismiss"))
                  ],
                  title: const Text('Error'),
                  content: Text(error.toString()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _WriteReviewScreen extends StatefulWidget {
  const _WriteReviewScreen({Key? key, required this.showId, required this.isLoading}) : super(key: key);
  final int showId;
  final bool isLoading;

  @override
  State<_WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<_WriteReviewScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int ratingSelected = 3;
    final provider = context.watch<WriteReviewProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Text(
                    'Write a review',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 40),
            child: RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                IconData(0xe5f9, fontFamily: 'MaterialIcons'),
                color: Color(0xff52368c),
              ),
              onRatingUpdate: (rating) {
                ratingSelected = rating.toInt();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff3d1d72))),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff3d1d72))),
                  labelText: 'Comment',
                  labelStyle: TextStyle(color: Color(0xff3d1d72))),
              autofocus: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, MediaQuery.of(context).viewInsets.bottom),
            child: ElevatedButton(
              child: widget.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Submit', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff52368c)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.5),
                  ),
                ),
              ),
              onPressed: () =>
                  provider.writeReview(SubmitReview(controller.text, ratingSelected, widget.showId), widget.showId),
            ),
          ),
        ],
      ),
    );
  }
}
