import 'package:flutter/material.dart';
import 'package:movie_monstar/widgets/cards/fav_movie_card.dart';

class FavMoviesListView extends StatelessWidget {
  const FavMoviesListView({Key key, this.favMovieNameList}) : super(key: key);

  final List<String> favMovieNameList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favMovieNameList.length,
      itemBuilder: (context, index) {
        final names = favMovieNameList[index];

        return FavMovieCard(
          movieName: names,
        );
      },
    );
  }
}
