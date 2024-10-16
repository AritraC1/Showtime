class Movies {
  String title;
  String backdropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double rating;

  Movies({
    required this.title,
    required this.backdropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.rating,
  });

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      title: json["title"],
      backdropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      rating: json["vote_average"],
    );
  }
}
