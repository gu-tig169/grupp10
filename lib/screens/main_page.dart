import 'dart:ui';

import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

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
            title: Text('The Movies App', textAlign: TextAlign.center),
            actions: <Widget>[
              PopupMenuButton<int>(
                icon: Icon(Icons.more_vert_rounded, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(value: 1,  child: Text('Första'),),
                  PopupMenuItem(value: 2, child: Text('Andra'))
                ],
                onSelected: (value) => print("value:$value"),
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
      child: Column(
        children: <Widget> [
          _searchBar(),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text("Trending", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900))
              )
            ),
          ),
          _movieList(),
        ]
      )
    )
  );
}

// Sökrutan.
Widget _searchBar() {
  TextEditingController textEditingController;
  return Row(
      children: <Widget> [
        Flexible(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Search for movies',
              labelStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              // Utför sökning, gör någonting med textEditingController.
            })
      ]
  );
}

// Listan med filmerna. Hårdkodad!
Widget _movieList(){
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 9, // Visar 9 st filmer nu.
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView( // Man kan scrolla mha touchskärmen.
              child: Column(
                children: <Widget> [
                  // Här är filmerna.
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("INSERT IMAGE"), // Vet inte hur man gör detta riktigt!
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Avengers: Endgame", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("120 min", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Rating: 4.5 stars", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  )
                ]
              ),
            )
          );
        }
      ),
    ),
  );
}
