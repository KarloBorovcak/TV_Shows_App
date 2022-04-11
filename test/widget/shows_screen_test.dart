import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/providers/review_provider.dart';
import 'package:tv_shows/screens/shows/show_detail_screen.dart';

import '../unit/register_provider_test.mocks.dart';

void main() {
  group('Show details screen test:', () {
    testWidgets('circular progress indicator showing', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ReviewProvider(MockNetworkingRepository(), '1'),
        child: MaterialApp(
            home: ShowDetailScreenWidget(
          show: Show('The Office', 'Office show', 2, 2.2, '', '1'),
          widget: const CircularProgressIndicator(),
        )),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('rating bar indicator showing', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ReviewProvider(MockNetworkingRepository(), '1'),
        child: MaterialApp(
            home: ShowDetailScreenWidget(
          show: Show('The Office', 'Office show', 2, 2.2, '', '1'),
          widget: null,
        )),
      ));

      expect(find.byType(RatingBarIndicator), findsOneWidget);
    });

    testWidgets('sliver app bar showing', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => ReviewProvider(MockNetworkingRepository(), '1'),
        child: MaterialApp(
            home: ShowDetailScreenWidget(
          show: Show('The Office', 'Office show', 2, 2.2, '', '1'),
          widget: null,
        )),
      ));

      expect(find.byType(SliverAppBar), findsOneWidget);
    });
  });
}
