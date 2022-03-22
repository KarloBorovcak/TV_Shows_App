import 'package:tv_shows/gen/assets.gen.dart';

class Review {
  String? comment;
  int rating;
  String userEmail;
  String imageUrl;
  static final allReviews = {
    'The Office': [
      Review(null, 3, 'netko@gmail.com', Assets.images.icProfilePlaceholder.path),
      Review('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 1,
          'netko@gmail.comnetko@gmail.comnetko@gmail.com', Assets.images.icProfilePlaceholder.path),
      Review('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 5, 'netko@gmail.com',
          Assets.images.icProfilePlaceholder.path)
    ],
    'Krv nije voda': [],
    'Stranger Things': []
  };

  Review(this.comment, this.rating, this.userEmail, this.imageUrl);
}
