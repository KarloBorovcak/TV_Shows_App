import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/show.dart';

class ShowList extends StatelessWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: ((context) => ShowProvider()), child: _ShowListState)
  }


}

class _ShowListState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showFetch = context.watch<ShowProvider>();
    var shows = [];
    while(showFetch.incrementShowIndex()){
      shows.add()
    }

    return Column(
      children: ,
    );
  }
}
