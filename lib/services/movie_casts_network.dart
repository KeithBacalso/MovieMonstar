import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_monstar/models/movie_casts.dart';
import 'dart:convert';

class MovieCastsNetwork {
  MovieCastsNetwork({@required this.url});

  final String url;

  Future<dynamic> fetchData() async {
    var _jsonDecode, _castsList;

    http.Response response = await http.get(Uri.parse(url));

    switch (response.statusCode) {
      case 200:
        final _castsBody = response.body;
        _jsonDecode = jsonDecode(_castsBody)["cast"];
        _castsList = List<MovieCasts>.from(
            _jsonDecode.map((model) => MovieCasts.fromJson(model)));
        return _castsList;
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
