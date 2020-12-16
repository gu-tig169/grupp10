import 'Movie.dart';

class MovieList {
  String listTitle;
  List<Movie> _movies;

  MovieList(String title) {
    listTitle = title;
    _movies = [];
  }

  int get count => _movies.length;
}
