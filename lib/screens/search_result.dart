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
          body: MovieListWidget(),
        ));
  }

  // Widget _movieWidget() {
  //   return Container(
  //       decoration: BoxDecoration(
  //         color: Colors.transparent,
  //       ),
  //       child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(children: <Widget>[
  //             Padding(
  //               padding: EdgeInsets.all(10),
  //               child: Container(
  //                   child: Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: Text("Action movies",
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.bold)))),
  //             ),
  //             // _searchList(),
  //             MovieListWidget(),
  //             _relatedInfo()
  //           ])));
  // }

  /*  Widget _relatedInfo() {
    // return Flexible(
    return Container(
        child: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('RELATED:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 25),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sci-Fi, Adventure, Action, Elliot Page, Leonardo Dicaprio',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, letterSpacing: 0.8),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    )); //);
  } */
}
