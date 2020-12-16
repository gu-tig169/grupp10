import 'dart:ui';
import 'package:MoviePKR/screens/savedLists_screen.dart';
import 'package:MoviePKR/screens/search_result.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/screens/movieDescription_screen.dart';

import '../util/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            centerTitle: true,
            title: Text('The Movies App', textAlign: TextAlign.center),
            actions: <Widget>[
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert_rounded, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text('My lists'),
                  ),
                  PopupMenuItem(value: 2, child: Text('Settings'))
                ],
                onSelected: (value) => {
                  if (value == 1)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SavedList()),
                      )
                    }
                },
              )
            ],
          ),
          body: _movieWidget(context, String)),
    );
  }
}

Widget _movieWidget(context, title) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            _searchBar(context),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
              child: Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Trending",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)))),
            ),
            _movieList(),
          ])));
}

// Sökrutan.
Widget _searchBar(BuildContext context) {
  TextEditingController textEditingController;
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Material(
      color: AppColors.primaryColor.withOpacity(0.7),
      elevation: 0.0,
      borderRadius: BorderRadius.circular(25.0),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                // Utför sökning, gör någonting med textEditingController.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResult(),
                    ));
              }),
          contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
          hintText: 'Search for movies',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

// Listan med filmerna. Hårdkodad!
Widget _movieList() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 9, // Visar 9 st filmer nu.
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              // Man kan scrolla mha touchskärmen.
              child: Column(children: <Widget>[
                // Här är filmerna.
                Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new DescriptionScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 260,
                            width: double.infinity,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 190,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/original/or06FN3Dka5tukK1e9sl16pB3iy.jpg"))),
                                ),
                              ),
                              Text("Avengers: Endgame",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)),
                              Text("120 min",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              Text("Rating: 4.5 stars",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600))
                            ])),
                      ),
                    ))
              ]),
            );
          }),
    ),
  );
}
//TODO: Extract main scaffold widget (with AppBar)
