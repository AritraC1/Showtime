import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:showtime/models/movies.dart';
import 'package:showtime/utils/constants.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  // List to store trending movies
  List<Movies> _trendingMovies = [];

  // Getter to access trending movies
  List<Movies> get trendingMovies => _trendingMovies;

  Future<void> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      _trendingMovies =
          decodedData.map((movie) => Movies.fromJson(movie)).toList();

      // Notify listeners to update the UI
      notifyListeners();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
}
