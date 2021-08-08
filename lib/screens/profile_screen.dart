import 'package:flutter/material.dart';
import 'package:movie_monstar/models/fav_movies.dart';
import 'package:movie_monstar/widgets/lists/fav_movies_listview.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = "profile_screen";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<FavMovies>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Valentina Acosta",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height / 4.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio: 3.0,
                  child: Image.asset(
                    "assets/images/valentina_cover.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: Row(
                    children: [
                      Hero(
                        tag: "archery",
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/valentina.png"),
                            radius: 50,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.bottomCenter,
                        child:
                            Text("Archer 🏹", style: TextStyle(fontSize: 14.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Favorite Movies:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Divider(),
                Container(
                  height: size.height - 330,
                  child: provider.favMovies == null ||
                          provider.favMovies.length == 0
                      ? Center(
                          child: Text(
                            "No favorite movies :(",
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        )
                      : FavMoviesListView(
                          favMovieNameList: provider.favMovies,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
