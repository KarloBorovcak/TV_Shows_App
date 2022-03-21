import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class ShowProvider extends ChangeNotifier {
  Show? get show => Show.allShows[_currentShowIndex];

  bool incrementShowIndex() {
    if (_currentShowIndex >= Show.allShows.length) {
      return false;
    }
    _currentShowIndex++;
    return true;
  }

  int _currentShowIndex = -1;
}

class Show {
  String name;
  String description;
  int numOfReviews;
  double averageRating;
  String imageUrl;
  static final allShows = [
    Show('Office', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 3, 3.6,
        Assets.images.theOffice1.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path),
    Show('Office', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 3, 3.6,
        Assets.images.theOffice1.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path),
    Show('Office', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 3, 3.6,
        Assets.images.theOffice1.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path)
  ];

  Show(this.name, this.description, this.numOfReviews, this.averageRating, this.imageUrl);
}
