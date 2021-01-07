import 'dart:ui';

import 'package:MoviePKR/util/constants.dart';
import 'package:MoviePKR/widgets/smoothStarRating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/models/Movie.dart';

class DescriptionScreen extends StatefulWidget {
  final int id;
  DescriptionScreen({Key key, this.id}) : super(key: key);

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  Movie movie;
  Future<Movie> getMovie() async {
    movie = await MovieLists.fetchMovieByID(widget.id);
    return movie;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getMovie(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<void> snapshot) {
          if (snapshot.hasData) {
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
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text('About movie',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 24)),
                  ),
                  body: _movieWidget(context, String)),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _movieWidget(context, title) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Column(children: <Widget>[
              _movieImage(),
              Container(height: 16),
              _movieDetails(),
            ]),
          ),
        ));
  }

  Widget _movieImage() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(5, 7))
      ]),
      height: 300,
      child: Image(
          image: movie.posterPath != null
              ? NetworkImage(ApiData.postersUrl + movie.posterPath)
              : AssetImage('assets/images/image_NA.png')),
    );
  }

  Widget _movieDetails() {
    return Expanded(
      child: Container(
          padding: EdgeInsets.all(12),
          color: Color.fromARGB(225, 18, 18, 30).withOpacity(0.3),
          height: 300,
          //width: 350,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                Container(height: 5),
                starRating(Movie.getRating(movie.rating)),
                Container(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.update_outlined,
                      color: Colors.white.withOpacity(0.5),
                      size: 20,
                    ),
                    Container(width: 5),
                    Text(movie.runTime.toString() + " min",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      movie.description,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                _buttons(),
              ])),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            // height: 40,
            // width: 100,
            child: FloatingActionButton.extended(
                heroTag:
                    "btn1", // Herotag måste finnas (för att vyn ska fungera på min dator).
                label: Text(
                  'ADD TO LIST',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                splashColor: AppColors.thirdColor,
                focusColor: AppColors.thirdColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.thirdColor, width: 3)),
                onPressed: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return setupAlertDialoadContainer();
                        });
                  });
                })),
        Container(width: 10),
        Container(
            height: 40,
            width: 100,
            child: FloatingActionButton.extended(
                heroTag:
                    "btn2", // Herotag måste finnas (för att vyn ska fungera på min dator).
                label: Text(
                  'RATE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.thirdColor,
                splashColor: AppColors.thirdColor,
                focusColor: AppColors.thirdColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.thirdColor, width: 3)),
                onPressed: () {
                  show();
                })),
        Container(width: 10)
      ]),
    );
  }

//Funktion som låter användaren ratea filmen, datan kan skickas till api och sedan visas i widgeten _starRating
  void show() {
    showDialog(
        barrierColor: Colors.black38,
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Theme(
              data: Theme.of(context).copyWith(
                  textTheme: TextTheme(
                      headline6: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  dialogBackgroundColor:
                      Color.fromARGB(225, 18, 18, 30).withOpacity(0.8)),
              child: RatingDialog(
                icon: Image.asset('assets/images/icon.png', height: 40),
                title: 'Movie review',
                description: 'What did you think about this movie? Tell us!',
                submitButton: 'Sumbit',
                accentColor: AppColors.primaryColor,
                onSubmitPressed: (int rating) {
                  print("onSubmitPressed: rating = $rating");
                },
              ));
        });
  }

  Widget setupAlertDialoadContainer() {
    final ScrollController _controllerOne = ScrollController();
    var list = Provider.of<MovieLists>(context, listen: false).movieLists;
    return Center(
      //AlertDialog needs to be wrapped in a Stateful widget so when a user changes the value in the dropdown, changes shall be visible to user.
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor:
                  Color.fromARGB(225, 18, 18, 30).withOpacity(0.95),
              title: Text(
                'Add to list',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                      height: height - 100,
                      width: width - 0,
                      child: Scrollbar(
                        radius: Radius.circular(20),
                        thickness: width = 3,
                        controller: _controllerOne,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: ListView.builder(
                              controller: _controllerOne,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  splashColor: AppColors.thirdColor,
                                  onTap: () {
                                    bool result = Provider.of<MovieLists>(
                                            context,
                                            listen: false)
                                        .addFilmToList(movie, index);
                                    result
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop(true);
                                              });
                                              return AlertDialog(
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.9),
                                                title: Text(
                                                    'Movie was added successfully',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              );
                                            })
                                        : showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                elevation: 10,
                                                backgroundColor: Color.fromARGB(
                                                        225, 18, 18, 30)
                                                    .withOpacity(0.95),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                title: Text(
                                                    'Movie has already been added',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)))
                                                ],
                                              );
                                            },
                                          );
                                    //   Navigator.of(context, rootNavigator: true).pop();
                                  },
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              AppColors.primaryColor
                                                  .withOpacity(0.5),
                                              AppColors.secondaryColor
                                                  .withOpacity(0.4)
                                            ],
                                          ),
                                        ),
                                        height: 50,
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20, top: 5),
                                                  child: Text(
                                                    list[index].listTitle,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ))
                                          ],
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ));
                },
              ),
              actionsPadding: EdgeInsets.only(right: 100),
              actions: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 40,
                      width: 90,
                      child: FloatingActionButton.extended(
                          backgroundColor: AppColors.thirdColor,
                          label: Text('CANCEL', style: TextStyle(fontSize: 12)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Container(height: 15),
                  ],
                )
              ],
            ));
      }),
    );
  }
}
//TODO: Add function to add to list button (pop up to show saved lists??)
