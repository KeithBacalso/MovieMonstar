import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movie_monstar/models/fav_movies.dart';
import 'package:movie_monstar/screens/view_movie_screen.dart';
import 'package:movie_monstar/utilities/constants.dart';
import 'package:movie_monstar/widgets/touchable_opacity.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    Key key,
    @required this.id,
    @required this.posterImg,
    @required this.backdropImg,
    @required this.title,
    @required this.voteAvg,
    @required this.releaseDate,
    @required this.overview,
  }) : super(key: key);

  final String id,
      posterImg,
      backdropImg,
      title,
      voteAvg,
      releaseDate,
      overview;

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isFavoriteMovie;

  @override
  void initState() {
    super.initState();
    _isFavoriteMovie = false;
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewMovieScreen(
            movieId: widget.id.toString(),
            posterImg: widget.posterImg,
            title: widget.title,
            voteAvg: widget.voteAvg,
            releaseDate: widget.releaseDate.toString(),
            overview: widget.overview,
            isFavMovie: _isFavoriteMovie,
          ),
        ),
      ),
      child: Container(
        height: 130.0,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image:
                NetworkImage(ImageUrls.movieImageUrl(widget.backdropImg) ?? ""),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: Image.network(
                    ImageUrls.movieImageUrl(widget.posterImg) ?? "",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        alignment: Alignment.center,
                        width: 100.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kActiveBlack),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.star,
                          color: Colors.yellow[300],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.voteAvg ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.yellow[300],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.releaseDate ?? "",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: TouchableOpacity(
                onTap: () {
                  final providerString =
                      Provider.of<FavMovies>(context, listen: false);
                  setState(() {
                    _isFavoriteMovie = !_isFavoriteMovie;

                    if (_isFavoriteMovie) {
                      providerString.addString(widget.title);
                    } else {
                      providerString.removeString(widget.title);
                    }
                  });
                },
                child: Icon(
                  IconlyBold.heart,
                  color: _isFavoriteMovie ? Colors.red : kInactiveBlack,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
