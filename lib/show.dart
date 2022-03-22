import 'package:flutter/material.dart';
import 'package:tv_shows/gen/assets.gen.dart';

class ShowsProvider extends ChangeNotifier {
  int get showCount => Show.allShows.length;
  List<Show> get showGetShows => Show.allShows;
}

class Show {
  String name;
  String description;
  int numOfReviews;
  double averageRating;
  String imageUrl;
  static final allShows = [
    Show(
        'The Office',
        'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.',
        3,
        3.4,
        Assets.images.icOffice.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path),
    Show(
        'The Office',
        'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.',
        3,
        3.6,
        Assets.images.icOffice.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path),
    Show(
        'The Office',
        'The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company. It aired on NBC from March 24, 2005, to May 16, 2013, lasting a total of nine seasons.',
        3,
        3.6,
        Assets.images.icOffice.path),
    Show('Krv nije voda', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 0, 0,
        Assets.images.krvNijeVoda2.path),
    Show('Stranger Things', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', 2, 5,
        Assets.images.strangerThingsPoster2.path)
  ];

  Show(this.name, this.description, this.numOfReviews, this.averageRating, this.imageUrl);
}
