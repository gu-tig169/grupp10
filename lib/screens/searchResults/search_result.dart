import 'package:MoviePKR/screens/mainPage/widgets/SearchBar.dart';
import 'package:MoviePKR/screens/movieDescription/movieDescription_screen.dart';
import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/rendering.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  Widget _searchedView() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new DescriptionScreen(id: movieList[index].id)));
            },
            child: Card(
              color: Colors.transparent,
              elevation: 0.8,
              child: Container(
                  height: 144,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _imageWidget(index),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movieList[index].title,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 6),
                            SmoothStarRating(
                              size: 15,
                              filledIconData: Icons.star,
                              isReadOnly: true,
                              color: Colors.orange,
                              borderColor: Colors.orange,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: true,
                              spacing: 2.0,
                              rating: Movie.getRating(
                                  movieList[index].rating.toDouble()),
                            ),
                            SizedBox(height: 6),
                            Row(children: <Widget> [
                              Text("Release date: ", style: TextStyle(
                                  color: Colors.white, fontSize: 12)),
                              Text(
                                movieList[index].releaseDate != null
                                    ? movieList[index].releaseDate
                                    : "N/A",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ]),
                            SizedBox(height: 6),
                            Text(
                              _getGenreList(movieList[index]),
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      )),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  String _getGenreList(Movie movie) {
    String genreList = "";
    int count = 0;
    for(var genre in movie.genres) {
      if(count < 3) {
        genreList += Provider.of<MovieLists>(context, listen: false).getGenre(genre) + " | ";
        count ++;
      }
    }
    if(genreList.length > 3) genreList = genreList.substring(0, genreList.length - 3);
    return genreList;
  }

  Widget _imageWidget(int index) {
    try {
      return Container(
        padding: EdgeInsets.fromLTRB(6, 6, 0, 6),
        alignment: Alignment.centerLeft,
        height: double.infinity,
        child: Image(image: NetworkImage(
            ApiData.postersUrl + movieList[index].posterPath)),
      );
    } catch (exception) {
      return Container(
          alignment: Alignment.centerLeft,
          width: 90,
          height: double.infinity,
          child: Image(image: AssetImage('assets/images/image_NA.png')));
    }
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
                        child: Text(
                            "Showing results for: '" + widget.search + "'",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)))),
              ),
              _searchedView(),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
