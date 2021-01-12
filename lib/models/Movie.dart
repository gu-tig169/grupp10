import 'dart:convert';
import 'dart:math';

class Movie {
  int id;
  String title;
  dynamic rating;
  List<dynamic> genres;
  String releaseDate;
  int runTime;
  String description;
  String posterPath;

  Movie(
      {this.id,
      this.title,
      this.rating,
      this.genres,
      this.releaseDate,
      this.description,
      this.posterPath,
      this.runTime});

  String imdbId;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['original_title'],
        rating: json['vote_average'],
        genres: json['genre_ids'],
        releaseDate: json['release_date'],
        description: json['overview'],
        posterPath: json['poster_path'],
        runTime: json['runtime']);
  }

  factory Movie.fromJsonGenres(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['original_title'],
        rating: json['vote_average'],
        genres: json['genres'],
        releaseDate: json['release_date'],
        description: json['overview'],
        posterPath: json['poster_path'],
        runTime: json['runtime']);
  }

  factory Movie.fromJsonNoRuntime(Map<String, dynamic> json) {
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
        'poster_path': movie.posterPath,
        'runtime': movie.runTime,
      };

  static double getRating(double value) {
    if (value == 0) value = 1;
    value = value / 2;
    double mod = pow(10.0, 1);
    return ((value * mod).round().toDouble() / mod);
  }

  static String checkDescription(String title) {
    if (title.isEmpty || title == null)
      return "No description available.";
    else
      return title;
  }

  static String checkReleaseDate(String releaseData) {
    if (releaseData.isEmpty || releaseData == null)
      return "N/A";
    else
      return releaseData;
  }

  static String checkRunTime(int runTime) {
    if (runTime == null || runTime == 0)
      return "Runtime N/A";
    else
      return runTime.toString() + " min";
  }

  ///
  ///This Method converts a list of Movies to a single string to be saved in sharedPreferences.
  ///
  static String encode(List<Movie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => Movie.toMap(movie))
            .toList(),
      );

  ///
  ///This method creates a Movie object from an XML file (JSON)
  ///
  static List<Movie> decode(String movies) {
    if (movies != null && movies.isNotEmpty) {
      try {
        return (json.decode(movies) as List<dynamic>)
            .map<Movie>((m) => Movie.fromJson(m))
            .toList();
      } catch (error) {
        return [];
      }
    } else {
      return [];
    }
  }
}
