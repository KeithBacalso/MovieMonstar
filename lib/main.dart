import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_monstar/models/fav_movies.dart';
import 'package:movie_monstar/screens/home_screen.dart';
import 'package:movie_monstar/screens/profile_screen.dart';
import 'package:movie_monstar/screens/view_movie_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MovieMonstar());
}

class MovieMonstar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    // Only portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => FavMovies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ViewMovieScreen.id: (context) => ViewMovieScreen(),
        },
      ),
    );
  }
}
