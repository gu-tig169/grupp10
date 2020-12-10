import 'dart:ui';

import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('The Movies App', textAlign: TextAlign.center),
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert_rounded, color: Colors.white),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text('Första'),
                ),
                PopupMenuItem(value: 2, child: Text('Andra'))
              ],
              onSelected: (value) {
                print("value:$value");
              },
            )
          ],
        ),
        body: _movieWidget(context, String));
    /*Center(
        child: Container( 
            decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            color: [AppColors.primaryColor, AppColors.secondaryColor],
          )),
            ),
      ),
    );*/
  }
}

Widget _movieWidget(context, title) {
  return Card(
      margin: const EdgeInsets.all(1.0),
      child: Container(
          decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      )));
}
