import 'package:flutter/material.dart';

class FavMovies extends ChangeNotifier {
  List<String> favMovies = [];
  bool isFavMovie = false;

  void setFav(bool isFav, int index) {
    final _newMovie = favMovies[index];
    favMovies[index] = _newMovie;
    notifyListeners();
  }

  void addString(String string) {
    favMovies.add(string);
    notifyListeners();
    print("YAHOOO!!!$favMovies");
  }

  void removeString(String string) {
    favMovies.remove(string);
    notifyListeners();
  }
}
