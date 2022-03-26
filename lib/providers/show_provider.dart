import 'package:tv_shows/providers/request_provider.dart';
import '../models/show.dart';
import '../utilities/networking_repository.dart';

class ShowsProvider extends RequestProvider<Show> {
  ShowsProvider(this._repository) {
    _repository.fetchShows();
  }
  final NetworkingRepository _repository;
  late List<Show> showsList;

  int get showCount => showsList.length;
  List<Show> get showGetShows => showsList;
}
