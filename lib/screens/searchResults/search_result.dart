import 'package:MoviePKR/screens/mainPage/widgets/SearchBar.dart';
import 'package:MoviePKR/widgets/movieList_listview.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/rendering.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Search Results',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: Column(children: <Widget>[
            // Padding here caused keyboard gap.
            searchBar(context),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("*insert what I searched for here*",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)))),
            ),
            Expanded(child: MovieListWidget()),
          ]),
        ));
  }
}
