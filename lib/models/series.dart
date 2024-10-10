class Series {
  String name;
  String backdropPath;
  String originalName;
  String overview;
  String posterPath;
  String releaseDate;
  double rating;

  Series({
    required this.name,
    required this.backdropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      name: json["name"],
      backdropPath: json["backdrop_path"],
      originalName: json["original_name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["first_air_date"],
      rating: json["vote_average"],
    );
  }
}
