import 'dart:convert';

import 'Movie.dart';

class MovieList {
  String listTitle;
  List<Movie> _movies = [];

  MovieList(String title) {
    listTitle = title;
    _movies = [];
    //test
    _movies.add(new Movie(
        id: 123,
        title: 'TestMovieTitle',
        description: 'TestMovieDescription TestMovie TestMovie TestMovie',
        genres: [1, 2, 3, 4],
        posterPath: '/6sG0kbEvAi3RRLcGGU5h8l3qAPa.jpg',
        rating: 8.0,
        releaseDate: '2020-12-20'));
  }

  MovieList.fromStorage(String title, List<Movie> list) {
    listTitle = title;
    _movies = list;
  }

  int get count => _movies.length;
  List<Movie> get movies => _movies; //William for get image from movies

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList.fromStorage(
        json['listTitle'], Movie.decode(json['movies']));
  }

  static Map<String, dynamic> toMap(MovieList movieList) => {
        'listTitle': movieList.listTitle,
        'movies': movieList._movies.length > 0
            ? Movie.encode(movieList._movies)
            : null
      };

  static String encode(List<MovieList> lists) => json.encode(
        lists
            .map<Map<String, dynamic>>((list) => MovieList.toMap(list))
            .toList(),
      );

  static List<MovieList> decode(String lists) =>
      (json.decode(lists) as List<dynamic>)
          .map<MovieList>((l) => MovieList.fromJson(l))
          .toList();
}
