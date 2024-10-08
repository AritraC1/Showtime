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

  // Pagination
  int _currentPage = 1; // Track the current page number
  bool _isLoading = false; // Track if a request is already in progress

  // Getter to access trending movies
  List<Movies> get trendingMovies => _trendingMovies;
  bool get isLoading => _isLoading;

  Future<void> getTrendingMovies({bool loadMore = false}) async {
    if (_isLoading) return; // Avoid making multiple requests at once
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('$_trendingUrl&page=$_currentPage'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      final List<Movies> fetchedMovies = decodedData.map((movie) => Movies.fromJson(movie)).toList();

      if (loadMore) {
        _trendingMovies.addAll(fetchedMovies); // Append the new movies
      } else {
        _trendingMovies = fetchedMovies; // Load initial movies
      }

      _currentPage++; // Increment the page number for the next fetch
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      throw Exception('Failed to load trending movies');
    }
  }
}
