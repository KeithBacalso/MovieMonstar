import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_monstar/models/movies.dart';

class MoviesNetwork {
  MoviesNetwork({@required this.url});

  final String url;

  Future<dynamic> fetchData() async {
    var _jsonDecode, _movieList;

    http.Response response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case 200:
        final _moviesBody = response.body;
        _jsonDecode = jsonDecode(_moviesBody)["results"];
        _movieList = List<Movies>.from(
            _jsonDecode.map((model) => Movies.fromJson(model)));
        return _movieList;
      case 401:
        return _renderResponseError("401", "Unauthorized.");
      case 404:
        return _renderResponseError("404", "Data not found.");
      default:
        break;
    }
  }

  Center _renderResponseError(String codeNum, String codeMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(codeNum, style: TextStyle(fontFamily: "Montserrat")),
          Text(codeMsg, style: TextStyle(fontFamily: "Montserrat")),
        ],
      ),
    );
  }
}
