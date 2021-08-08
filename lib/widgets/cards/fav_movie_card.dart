import 'package:flutter/material.dart';

class FavMovieCard extends StatelessWidget {
  const FavMovieCard({
    Key key,
    @required this.movieName,
  }) : super(key: key);

  final String movieName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movieName),
    );
  }
}
