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
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new DescriptionScreen(id: trendingList[index].id)));
          },
          child: Card(
            margin: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.black.withOpacity(0.2))),
            elevation: 1,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image(
                      width: 190,
                      height: 254,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          ApiData.postersUrl + trendingList[index].posterPath)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(trendingList[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      child: starRating(
                          Movie.getRating(trendingList[index].rating)),
                    )),
              ],
            ),
          ),
        );
      }, childCount: trendingList.length));
}
