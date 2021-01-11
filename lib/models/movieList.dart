import 'dart:convert';
import 'Movie.dart';

class MovieList {
  String listTitle;
  List<Movie> _movies = [];

  MovieList(String title) {
    listTitle = title;
    _movies = [];
  }

  MovieList.fromStorage(String title, List<Movie> list) {
    listTitle = title;
    _movies = list;
  }

  int get count => _movies.length;
  List<Movie> get movies => _movies;

  ///
  ///Constructor from JSOM, takes parameters from JSON/XML file.
  ///
  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList.fromStorage(
        json['listTitle'], Movie.decode(json['movies']));
  }

  ///
  ///Converts MovieList object to a Key-Value pair. (json)
  ///
  static Map<String, dynamic> toMap(MovieList movieList) => {
        'listTitle': movieList.listTitle,
        'movies':
            movieList._movies.length > 0 ? Movie.encode(movieList._movies) : ""
      };

  ///
  ///This Method converts a list of MovieLists to a single string to be saved in sharedPreferences.
  ///
  static String encode(List<MovieList> lists) => json.encode(
        lists
            .map<Map<String, dynamic>>((list) => MovieList.toMap(list))
            .toList(),
      );

  ///
  ///This method creates a list of MovieList from an XML file (JSON)
  ///
  static List<MovieList> decode(String lists) =>
      (json.decode(lists) as List<dynamic>)
          .map<MovieList>((l) => MovieList.fromJson(l))
          .toList();
}
