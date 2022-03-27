import 'package:tv_shows/providers/request_provider.dart';
import '../models/show.dart';
import '../utilities/networking_repository.dart';

class ShowsProvider extends RequestProvider<List<Show>> {
  ShowsProvider(this._repository) {
    fetchShows();
  }
  final NetworkingRepository _repository;
  List<Show> showsList = [];

  int get showCount => showsList.length;
  List<Show> get showGetShows => showsList;

  void fetchShows() async {
    executeRequest(requestBuilder: () async => showsList = await _repository.fetchShows());
  }
}
