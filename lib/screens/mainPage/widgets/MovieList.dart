import 'package:MoviePKR/models/Movie.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/movieDescription/movieDescription_screen.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/smoothStarRating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

SliverGrid movieList(BuildContext context) {
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
        return Container(
            child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new DescriptionScreen(id: trendingList[index].id)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 10,
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image(
                        image: NetworkImage(ApiData.postersUrl +
                            trendingList[index].posterPath)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(trendingList[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: starRating(Movie.getRating(trendingList[index].rating)),
              ),
            ],
          ),
        ));
      }, childCount: trendingList.length));
}
