import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:movie_monstar/services/movie_casts_network.dart';
import 'package:movie_monstar/utilities/constants.dart';
import 'package:movie_monstar/widgets/lists/casts_gridview.dart';
import 'package:movie_monstar/widgets/touchable_opacity.dart';

class ViewMovieScreen extends StatefulWidget {
  static const String id = "view_movie_screen";

  const ViewMovieScreen({
    Key key,
    this.movieId,
    this.posterImg,
    this.title,
    this.voteAvg,
    this.releaseDate,
    this.overview,
    this.isFavMovie,
  }) : super(key: key);

  final String movieId, posterImg, title, voteAvg, releaseDate, overview;
  final bool isFavMovie;

  @override
  _ViewMovieScreenState createState() => _ViewMovieScreenState();
}

class _ViewMovieScreenState extends State<ViewMovieScreen> {
  dynamic _fetchCasts, _casts;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _fetchCastsData(ApiUrls.movieCastsUrl(widget.movieId));
  }

  // If type is List render casts, otherwise a response error message.
  Widget _renderResponseErrorOrCasts() {
    return _fetchCasts is List ? _renderCasts(_casts) : _fetchCasts;
  }

  Widget _renderCasts(dynamic fetchMovies) {
    return _fetchCasts.length == 0 || _fetchCasts == null
        ? _renderMessage()
        : CastsGridview(castList: _casts);
  }

  Widget _renderMessage() {
    return Center(
      child: Text(
        "Movie does not exist.",
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  void _fetchCastsData(String url) async {
    MovieCastsNetwork movieCastsNetwork = MovieCastsNetwork(url: url);
    _isLoading = true;

    try {
      _fetchCasts = await movieCastsNetwork.fetchData();
      _isLoading = false;

      if (this.mounted) {
        setState(() {
          _casts = _fetchCasts;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            image:
                NetworkImage(ImageUrls.movieImageUrl(widget.posterImg) ?? ""),
          ),
        ),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TouchableOpacity(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      IconlyBold.arrowLeft2,
                      size: 50.0,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Image.network(
                      ImageUrls.movieImageUrl(widget.posterImg),
                    ),
                  ),
                  Icon(
                    IconlyBold.heart,
                    size: 50.0,
                    color: widget.isFavMovie ? Colors.red : kInactiveBlack,
                  ),
                ],
              ),
            )),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                child: Container(
                  width: size.width,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconlyBold.star,
                                    color: Colors.yellow[300],
                                    size: 30.0,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.voteAvg ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                      color: Colors.yellow[300],
                                    ),
                                  ),
                                ],
                              ),
                              TouchableOpacity(
                                child: Icon(
                                  IconlyBold.play,
                                  color: kActiveBlack,
                                  size: 80.0,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                            ),
                          ),
                          Text(
                            widget.releaseDate,
                            style: TextStyle(
                              color: kInactiveBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              widget.overview,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Text(
                            "Casts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21.0,
                            ),
                          ),
                          _isLoading
                              ? SizedBox(
                                  height: 200.0,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kActiveBlack),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: size.width,
                                  child: _renderResponseErrorOrCasts(),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
