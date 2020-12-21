import 'dart:convert';

import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/models/movieList.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MovieLists with ChangeNotifier {
  SharedPreferences prefs;

  List<MovieList> _myLists = [];
  List<Movie> _trendingMovies = [];

  List<MovieList> get movieLists => [..._myLists];
  List<Movie> get trendingList => [..._trendingMovies];

  void addNewList(MovieList newList) {
    _myLists.add(newList);
    saveToSF();
    notifyListeners();
  }

  void removeList(MovieList movieList) {
    _myLists.remove(movieList);
    saveToSF();
    notifyListeners();
  }

  MovieList getListAtIndex(int index) {
    return _myLists[index];
  }

  Future<void> fetchTrendingList() async {
    try {
      final response = await http.get(
          'https://api.themoviedb.org/3/trending/movie/day?api_key=837ac1cc736282b8a8c9d58d52cd5a7c');

      var data = json.decode(response.body)['results'];
      for (var item in data) {
        _trendingMovies.add(Movie.fromJson(item));
      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> saveToSF() async {
    var decoded = MovieList.encode(_myLists);
    print(decoded);
    prefs = await SharedPreferences.getInstance();
    return await prefs.setString('key', decoded);
  }

  _getList() async {
    prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('key');
    return data;
  }

  fetchSavedListsFromSF() async {
    var list = await _getList();
    if (list != null) _myLists = MovieList.decode(list);
  }
}
