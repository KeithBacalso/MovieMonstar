import 'package:flutter/material.dart';

const kActiveBlack = Colors.black;
const kInactiveBlack = Colors.black38;

class ImageUrls {
  static String movieImageUrl(String path) =>
      "https://image.tmdb.org/t/p/original/$path";
}

class ApiUrls {
  static String popularMoviesUrl() =>
      "https://api.themoviedb.org/3/movie/popular?api_key=1999f4264f1a353af6da45e22a775dab&language=en-US&page=1";
  static String searchMoviesUrl(String movie) =>
      "https://api.themoviedb.org/3/search/movie?api_key=1999f4264f1a353af6da45e22a775dab&query=$movie&page=1";
  static String movieCastsUrl(String movieId) =>
      "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=1999f4264f1a353af6da45e22a775dab&language=en-US";
}
