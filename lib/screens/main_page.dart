import 'dart:ui';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/savedLists_screen.dart';
import 'package:MoviePKR/screens/searchResults/search_result.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/smoothStarRating.dart';
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
    print('kToolbarHeight: ' + kToolbarHeight.toString());

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
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 180,
                floating: true,
                pinned: true,
                snap: true,
                elevation: 50,
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                // backgroundColor: Colors.transparent,

                title: Text(
                  'The Movies App',
                  style: TextStyle(fontSize: 26),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 80.0),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                searchBar(context),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Trending',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert_rounded, color: Colors.white),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text('My lists'),
                      ),
                      PopupMenuItem(value: 2, child: Text('About'))
                    ],
                    onSelected: (value) => {
                      if (value == 1)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SavedList()),
                          )
                        }
                    },
                  )
                ],
              ),
              _movieList(context)
            ],
          )),
    );
  }
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
                          builder: (context) => SearchResult(),
                        ));
                  }
                }),
            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            hintText: 'Search for movies',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  });
}

SliverGrid _movieList(BuildContext context) {
  //TODO: implement SliverAppBar
  var trendingList = Provider.of<MovieLists>(context).trendingList;
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight) / 2;
  final double itemWidth = size.width / 2;

  return SliverGrid(
      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: (itemWidth / itemHeight),
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
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
                    child: Align(
                      alignment: Alignment.center,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child:
                      starRating(Movie.getRating(trendingList[index].rating)),
                ),
              ],
            ),
          ),
        );
      }, childCount: trendingList.length));
}
