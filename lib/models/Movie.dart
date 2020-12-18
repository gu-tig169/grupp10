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
}
//Todo: do we need runTIme?
