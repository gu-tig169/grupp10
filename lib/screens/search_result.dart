import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/rendering.dart';

class SearchResult extends StatelessWidget {
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
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Search Results',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: _movieWidget(),
        ));
  }

  Widget _movieWidget() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Action movies",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)))),
              ),
              _searchList(),
              _relatedInfo()
            ])));
  }

  Widget _searchList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.transparent,
            elevation: 0.8,
            child: Container(
              height: 100,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Inception.jpg"))),
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Inception',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8),
                              ),
                              Container(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Action',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        letterSpacing: 0.8),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    '|',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Adventure',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        letterSpacing: 0.8),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '|',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Sci-Fi',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        letterSpacing: 0.8),
                                  )
                                ],
                              ),
                              Container(height: 5),
                              Text(
                                  'Stars:  Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white))
                            ],
                          )))
                ],
              ),
            ),
          );
        });
  }

  Widget _relatedInfo() {
    return Flexible(
        child: Container(
            child: Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('RELATED:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 25),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sci-Fi, Adventure, Action, Elliot Page, Leonardo Dicaprio',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, letterSpacing: 0.8),
                  ),
                ],
              )),
            ],
          ),
          Container(
            height: 5,
          ),
        ],
      ),
    )));
  }
}
