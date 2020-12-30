import 'package:MoviePKR/screens/savedLists/savedLists_screen.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert_rounded, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('My lists'),
        ),
        PopupMenuItem(value: 2, child: Text('About'))
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
