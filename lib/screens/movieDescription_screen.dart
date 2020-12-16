import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DescriptionScreen extends StatefulWidget {
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
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
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('About movie',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24)),
          ),
          body: _movieWidget(context, String)),
    );
  }

  Widget _movieWidget(context, title) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Container(
                    child: Align(
                  alignment: Alignment.centerLeft,
                )),
              ),
              _movieImage(),
            ])));
  }

  Widget _movieImage() {
    return Expanded(
        child: Column(children: [
      Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 6,
              offset: Offset(5, 7))
        ]),
        height: 300,
        child: Image.asset('assets/images/avengers.jpg'),
      ),
      Container(height: 30),
      _textBox(),
    ]));
  }

  Widget _textBox() {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 10),
        color: Color.fromARGB(225, 18, 18, 30).withOpacity(0.3),
        height: 200,
        width: 350,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AVENGERS: END GAME',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
              Container(height: 5),
              _shortInfo(),
              Container(height: 10),
              _movieDescription(),
              _buttons(),
            ]));
  }

  Widget _shortInfo() {
    return Row(
      children: [
        Icon(
          Icons.update_outlined,
          color: Colors.white.withOpacity(0.5),
          size: 20,
        ),
        Text('120 min',
            style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold)),
        Container(width: 138),
        Text('4.5',
            style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold)),
        Container(width: 5),
        _starRating(),
      ],
    );
  }

// Här kan summa av användares rating visas, vet inte hur svårt detta är dock
  Widget _starRating() {
    return SmoothStarRating(
      size: 15,
      filledIconData: Icons.star,
      color: Colors.orange,
      borderColor: Colors.orange,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
    );
  }

  Widget _movieDescription() {
    return Container(
      height: 80,
      child:
          Text('Movie description...', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buttons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
          height: 40,
          width: 100,
          child: FloatingActionButton.extended(
              heroTag:
                  "btn1", // Herotag måste finnas (för att vyn ska fungera på min dator).
              label: Text(
                'ADD TO LIST',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              splashColor: AppColors.thirdColor,
              focusColor: AppColors.thirdColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: AppColors.thirdColor, width: 3)),
              onPressed: (
                  //Här kan man antingen direkt lägga till filmen i listan eller ha en dialog som frågar
                  //en till gång om man vill lägga till filmen på sin lista samt i vilken lista osv.
                  ) {})),
      Container(width: 10),
      Container(
          height: 40,
          width: 100,
          child: FloatingActionButton.extended(
              heroTag:
                  "btn2", // Herotag måste finnas (för att vyn ska fungera på min dator).
              label: Text(
                'RATE',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
    ]);
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
}
//TODO: Add function to add to list button (pop up to show saved lists??)
