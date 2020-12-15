import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/movieList_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieListScreen extends StatefulWidget {
  State<StatefulWidget> createState() => new _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
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
            title: Text('The name of the list', textAlign: TextAlign.center),
          ),
          body: MovieListWidget(),
        ));
  }
}
