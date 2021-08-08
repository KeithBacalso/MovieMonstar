import 'package:flutter/material.dart';
import 'package:movie_monstar/screens/profile_screen.dart';
import 'package:movie_monstar/services/movies_network.dart';
import 'package:movie_monstar/utilities/constants.dart';
import 'package:movie_monstar/widgets/lists/popular_movies_listview.dart';
import 'package:movie_monstar/widgets/touchable_opacity.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "search_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();
  dynamic _fetchMovies, _movies;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _fetchMoviesData(ApiUrls.popularMoviesUrl());
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  // If type is List render popular movies, otherwise a response error message.
  Widget _renderResponseErrorOrPopularMovies() {
    return _fetchMovies is List ? _renderPopularMovies(_movies) : _fetchMovies;
  }

  Widget _renderPopularMovies(dynamic fetchMovies) {
    return _fetchMovies.length == 0
        ? _renderMessage()
        : PopularMoviesListView(movieList: fetchMovies);
  }

  Widget _renderMessage() {
    return Center(
      child: Text(
        "Movie not found.",
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  void _fetchMoviesData(String url) async {
    MoviesNetwork moviesNetwork = MoviesNetwork(url: url);
    _isLoading = true;

    try {
      _fetchMovies = await moviesNetwork.fetchData();
      _isLoading = false;

      if (this.mounted) {
        setState(() {
          _movies = _fetchMovies;
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
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 120.0,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Valentina!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: size.width / 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Watch your favorite movies today",
                          style: TextStyle(
                            color: kInactiveBlack,
                            fontSize: size.width / 27.0,
                          ),
                        ),
                      ],
                    ),
                    TouchableOpacity(
                      onTap: () =>
                          Navigator.pushNamed(context, ProfileScreen.id),
                      child: Hero(
                        tag: "archery",
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/valentina.png"),
                          radius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: kActiveBlack,
                  ),
                  child: Container(
                    height: 35.0,
                    child: TextField(
                      onSubmitted: (movie) {
                        movie = movie.toLowerCase();
                        setState(() {
                          _fetchMoviesData(ApiUrls.searchMoviesUrl(movie));
                        });
                      },
                      cursorColor: Colors.black,
                      controller: _textEditingController,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        hintText: "Search Movie",
                        hintStyle: TextStyle(
                          color: kInactiveBlack,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kActiveBlack),
              ),
            )
          : _renderResponseErrorOrPopularMovies(),
    );
  }
}
