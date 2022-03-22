import 'package:flutter/material.dart';
import '../models/show.dart';

class ShowsProvider extends ChangeNotifier {
  int get showCount => Show.allShows.length;
  List<Show> get showGetShows => Show.allShows;
}
