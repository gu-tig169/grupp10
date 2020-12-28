import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/screens/main_page.dart';
import 'package:flutter/rendering.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';

import '../movieDescription_screen.dart';

class SearchResult extends StatefulWidget {

  final String search;
  SearchResult({Key key, this.search}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<Movie> movieList;
  Future<List<Movie>> getMovieList(String query) async {
    movieList = await MovieLists.fetchMovies(query);
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    getMovieList(widget.search);
    //var searchedList = Provider.of<MovieLists>(context).trendingList;
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
          body: _aWidget(),
        ));



  }

  Widget _aWidget() {
    return FutureBuilder<List<Movie>>(
        future: getMovieList(widget.search),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            return Column(children: <Widget>[
              // Padding here caused keyboard gap.
              searchBar(context),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Showing results for: '" + widget.search + "'",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))),
              ),
              _movieList(context),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }


  Widget _movieList(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(movieList.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new DescriptionScreen(id: movieList[index].id)));
            },
            child: Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 1,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(movieList[index].title,
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
                    child: Text(movieList[index].rating.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),),],),),);}),),);

  }



}
