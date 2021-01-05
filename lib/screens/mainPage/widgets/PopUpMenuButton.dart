import 'package:MoviePKR/screens/savedLists/savedLists_screen.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color.fromRGBO(58, 66, 86, 1.0),
      icon: Icon(Icons.more_vert_rounded, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(
          textStyle: TextStyle(color: Colors.white, fontSize: 14),
          value: 1,
          child: Text('My lists', textAlign: TextAlign.center),
        ),
        PopupMenuItem(
            textStyle: TextStyle(color: Colors.white, fontSize: 14),
            value: 2,
            child: Text('About', textAlign: TextAlign.center))
      ],
      onSelected: (value) => {
        if (value == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedList()),
            )
          }
      },
    );
  }
}
