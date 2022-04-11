import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/show.dart';
import 'package:tv_shows/models/user.dart';
import 'package:tv_shows/widgets/materialapp_scaffold.dart';
import 'package:tv_shows/widgets/review_widget.dart';
import 'package:tv_shows/widgets/show_card.dart';

void main() {
  group('Custom widget test:', () {
    group('ReviewWidget ->', () {
      testWidgets('has star', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
          child: ReviewWidget(
            review: Review('Ovo je comment', 3, User('1', 'email@gmail.com', null), '1'),
          ),
        ));

        expect(find.byType(Icon), findsOneWidget);
      });

      testWidgets('has email', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
          child: ReviewWidget(
            review: Review('Ovo je comment', 3, User('1', 'email@gmail.com', null), '1'),
          ),
        ));

        expect(find.byKey(const ValueKey('userEmail')), findsOneWidget);
      });

      testWidgets('has placeholder avatar', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
          child: ReviewWidget(
            review: Review('Ovo je comment', 3, User('1', 'email@gmail.com', null), '1'),
          ),
        ));

        expect(find.byKey(const ValueKey('placeholderAvatar')), findsOneWidget);
      });

      testWidgets('has rating', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
          child: ReviewWidget(
            review: Review('Ovo je comment', 3, User('1', 'email@gmail.com', null), '1'),
          ),
        ));

        expect(find.byKey(const ValueKey('reviewRating')), findsOneWidget);
      });
    });

    group('ShowCard ->', () {
      testWidgets('has title', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
            child: ShowCard(
          index: 0,
          showArray: [Show('The Office', 'Office show', 2, 2.2, '', '1')],
        )));

        expect(find.byKey(const ValueKey('showTitle')), findsOneWidget);
      });

      testWidgets('has description', (tester) async {
        await tester.pumpWidget(MaterialAppAndScaffold(
            child: ShowCard(
          index: 0,
          showArray: [Show('The Office', 'Office show', 2, 2.2, '', '1')],
        )));

        expect(find.byKey(const ValueKey('showDesc')), findsOneWidget);
      });
    });
  });
}
