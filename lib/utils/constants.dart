import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static const imagePath = 'https://image.tmdb.org/t/p/w500';
}