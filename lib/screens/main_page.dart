import 'dart:ui';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/savedLists_screen.dart';
import 'package:MoviePKR/screens/searchResults/search_result.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/screens/movieDescription_screen.dart';
import 'package:provider/provider.dart';
import 'package:MoviePKR/models/Movie.dart';

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
          resizeToAvoidBottomPadding: true,
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
                        MaterialPageRoute(builder: (context) => SavedList()),)}},)],),
          body: _movieWidget(context, String)),);}

}

Widget _movieWidget(context, title) {

  return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: <Widget>[
        searchBar(context),
        Container(
            padding: EdgeInsets.all(16),
            child: Text("Trending",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700))),
        _movieList(context),
      ]));

}

Widget searchBar(BuildContext context) {

  TextEditingController textEditingController = TextEditingController();

  return Builder(builder: (context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Material(
        color: AppColors.primaryColor.withOpacity(0.7),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(25.0),
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  if (textEditingController.text.isEmpty) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor:
                            AppColors.secondaryColor.withOpacity(0.8),
                        content: Text(
                          'Search text is empty',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => new SearchResult(search: textEditingController.text),
                        ));
                  }
                }),
            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            hintText: 'Search for movies',
            hintStyle: TextStyle(color: Colors.white),),),),);});

}

Widget _movieList(BuildContext context) {

  //TODO: implement SliverAppBar
  var trendingList = Provider.of<MovieLists>(context).trendingList;
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;

  return Expanded(
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      children: List.generate(trendingList.length, (index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new DescriptionScreen(id: trendingList[index].id)));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 1,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image(
                      image: NetworkImage(
                          ApiData.postersUrl + trendingList[index].posterPath)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(trendingList[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text((Movie.getRating(trendingList[index].rating)).toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),),],),),);}),),);

}

//TODO: Extract main scaffold widget (with AppBar)
//TODO: Fix padding under ListView
//TODO: Implement grid view above card to show more films by raw.
