import 'package:MoviePKR/models/movieList.dart';
import 'package:flutter/cupertino.dart';

class MovieLists with ChangeNotifier {
  List<MovieList> _myLists = [];

  // List<MovieList> get movieLists => [..._myLists];
  List<MovieList> get movieLists => _myLists;

  void addNewList(MovieList newList) {
    _myLists.add(newList);
    notifyListeners();
  }

  void removeList(MovieList movieList) {
    _myLists.remove(movieList);
    notifyListeners();
  }

  MovieList getListAtIndex(int index) {
    //TODO Check index is valid
    return _myLists[index];
  }

  void createTest() {
    for (int i = 0; i < 10; i++) {
      _myLists.add(new MovieList('Movie list no. $i'));
      print('added $i');
    }
  }
}
