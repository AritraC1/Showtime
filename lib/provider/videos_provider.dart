import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:showtime/models/videos.dart';
import 'package:showtime/utils/constants.dart';
import 'package:http/http.dart' as http;

class VideosProvider with ChangeNotifier {
  List<Videos> _trailers = [];
  bool _isLoading = false;

  List<Videos> get trailers => _trailers;

  bool get isLoading => _isLoading;

  // Fetch videos for a specific movie by its ID
  Future<void> fetchMovieVideos(int movieId) async {
    _isLoading = true;
    notifyListeners();

    final url =
        ' https://api.themoviedb.org/3/movie/{movie_id}/videos?api_key=${Constants.apiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['results'] as List;

      // Map the JSON data to a list of Videos objects
      _trailers = jsonData.map((video) => Videos.fromJson(video)).toList();
    } else {
      throw Exception('Failed to fetch videos');
    }

    _isLoading = false;
    notifyListeners();
  }
}
