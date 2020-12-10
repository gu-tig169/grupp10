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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
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
        body: _movieWidget(context, String));
    // Tror vi kan ta bort grejerna under här.
    /*Center(
        child: Container( 
            decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            color: [AppColors.primaryColor, AppColors.secondaryColor],
          )),
            ),
      ),
    );*/
  }
}

Widget _movieWidget(context, title) {
  return Card(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient( // Flyttade lineargradient hit.
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
            ),
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget> [
              _searchBar(),
              _movieList(),
            ]
          )
        )
      )
  );
}

// Sökrutan.
Widget _searchBar() {
  TextEditingController textEditingController;
  return Row(
      children: <Widget> [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: 'Search for movies',
              labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
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

// Listan med filmerna.
Widget _movieList(){
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 6, // Visar 6 st filmer nu.
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [
                // Här är filmerna.
                Text("Avengers: Endgame", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                Text("120 min", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                Text("Rating: 4.5 stars", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400))
              ]
            )
          );
        }
      ),
    ),
  );
}
