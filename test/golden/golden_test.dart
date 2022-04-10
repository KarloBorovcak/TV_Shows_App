import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/widgets/materialapp_scaffold.dart';
import 'package:tv_shows/widgets/no_shows.dart';
import 'package:tv_shows/widgets/review_widget.dart';
import 'package:tv_shows/widgets/show_card.dart';

void main() {
  testGoldens('ShowCardWidget test', (tester) async {
    await loadAppFonts();

    tester.pumpWidgetBuilder(MaterialAppAndScaffold(
        child: ShowCard(
      index: 0,
      showArray: [Show('The Office', 'Office show', 2, 2.2, '', '1')],
    )));

    await screenMatchesGolden(tester, 'ShowCard');
  });

  testGoldens('ReviewWidget test', (tester) async {
    await loadAppFonts();

    tester.pumpWidgetBuilder(
      ReviewWidget(
        review: Review('Ovo je comment', 3, User('1', 'email@gmail.com', ''), '1'),
      ),
    );

    await screenMatchesGolden(tester, 'ReviewWidget');
  });

  testGoldens('NoShows error widget', (tester) async {
    await loadAppFonts();

    tester.pumpWidgetBuilder(const NoShows());

    await screenMatchesGolden(tester, 'NoShowsWidget');
  });
}
