import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:showtime/models/movies.dart';
import '../utils/constants.dart';

class Api {
  static const _trendingUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';


  Future<List<Movies>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('Something happened');
    }
  }
}
