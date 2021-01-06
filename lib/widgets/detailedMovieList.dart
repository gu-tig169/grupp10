import 'package:MoviePKR/screens/movieDescription/movieDescription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:MoviePKR/widgets/imageWidget.dart';

Widget detailedMovieList(List<Movie> movieList, String typeOfList) {
  //return Expanded(
  //child: ListView.builder(

  return ListView.builder(
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
                  imageWidget(index, movieList),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movieList[index].title,
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                        Row(children: <Widget>[
                          Text("Release date: ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          Text(
                            movieList[index].releaseDate != null
                                ? movieList[index].releaseDate
                                : "N/A",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ]),
                        SizedBox(height: 6),
                        Text(
                          Provider.of<MovieLists>(context, listen: false)
                              .getGenreList(movieList[index],
                                  typeOfList), //for two diffrent list
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
                ],
              )),
        ),
      );
    },
    //),
  );
}