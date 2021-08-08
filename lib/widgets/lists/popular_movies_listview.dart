import 'package:flutter/material.dart';
import 'package:movie_monstar/models/movies.dart';
import 'package:movie_monstar/widgets/cards/movie_card.dart';

class PopularMoviesListView extends StatelessWidget {
  const PopularMoviesListView({@required this.movieList});
  final List<Movies> movieList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        final movies = movieList[index];

        return MovieCard(
          id: movies.id.toString(),
          posterImg: movies.posterPath,
          backdropImg: movies.backdropPath,
          title: movies.title,
          voteAvg: movies.voteAverage.toString(),
          releaseDate: movies.releaseDate,
          overview: movies.overview,
        );
      },
    );
  }
}
