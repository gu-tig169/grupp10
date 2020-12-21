import 'dart:convert';

///A model for movie instances.

class Movie {
  int id;
  String title;
  double rating;
  List<dynamic> genres;
  // String language;
  String releaseDate;
  // int runTime;
  String description;
  String posterPath;

  Movie(
      {this.id,
      this.title,
      this.rating,
      this.genres,
      this.releaseDate,
      this.description,
      this.posterPath});

  // Movie.fromMovie(Movie movie, int duration) {
  //   this.runTime = duration;
  // }

  //OPTIONAL
  String imdbId;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['original_title'],
        rating: json['vote_average'],
        genres: json['genre_ids'],
        releaseDate: json['release_date'],
        description: json['overview'],
        posterPath: json['poster_path']);
  }

  static Map<String, dynamic> toMap(Movie movie) => {
        'id': movie.id,
        'original_title': movie.title,
        'vote_average': movie.rating,
        'genre_ids': movie.genres,
        'release_date': movie.releaseDate,
        'overview': movie.description,
        'poster_path': movie.posterPath
      };

  static String encode(List<Movie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => Movie.toMap(movie))
            .toList(),
      );

  static List<Movie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<Movie>((m) => Movie.fromJson(m))
          .toList();
}

//Todo: do we need runTIme?
