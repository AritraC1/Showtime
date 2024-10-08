import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:showtime/models/series.dart';
import 'package:showtime/utils/constants.dart';
import 'package:http/http.dart' as http;

class MoviesProvider with ChangeNotifier {
  static const _trendingSeriesUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  // List to store trending movies
  List<Series> _trendingSeries = [];

  // Getter to access trending movies
  List<Series> get trendingSeries => _trendingSeries;

  Future<void> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingSeriesUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      _trendingSeries =
          decodedData.map((tvSeries) => Series.fromJson(tvSeries)).toList();

      // Notify listeners to update the UI
      notifyListeners();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
}
