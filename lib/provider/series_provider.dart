import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:showtime/models/series.dart';
import 'package:showtime/utils/constants.dart';
import 'package:http/http.dart' as http;

class SeriesProvider with ChangeNotifier {
  static const _trendingSeriesUrl =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.apiKey}';

  // List to store trending 
  List<Series> _trendingSeries = [];

  // List to store my favourite series
  final List<Series> _favouriteSeries = [];

  // Getter to access trending 
  List<Series> get trending => _trendingSeries;
  List<Series> get favoriteSeries => _favouriteSeries;

  bool isFavorite(Series tv) {
    return _favouriteSeries.contains(tv);
  }

  void toggleFav(Series tv) {
    if(isFavorite(tv)) {
      _favouriteSeries.remove(tv);
    }
    else {
      _favouriteSeries.add(tv);
    }
    notifyListeners();
  }

  // Pagination
  int _currentPage = 1; // Track the current page number
  bool _isLoading = false; // Track if a request is already in progress

  bool get isLoading => _isLoading;

  Future<void> getTrendingSeries({bool loadMore = false}) async {
    if (_isLoading) return; // Avoid making multiple requests at once
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('$_trendingSeriesUrl&page=$_currentPage'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      final List<Series> fetched = decodedData.map((tv) => Series.fromJson(tv)).toList();

      if (loadMore) {
        _trendingSeries.addAll(fetched); // Append the new
      } else {
        _trendingSeries = fetched; // Load initial
      }

      _currentPage++; // Increment the page number for the next fetch
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      throw Exception('Failed to load trending ');
    }
  }
}
