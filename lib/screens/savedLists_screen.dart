import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';

class SavedListsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SavedListsScreenState();
}

class SavedListsScreenState extends State<SavedListsScreen> {
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
      child: Text('hej'),
    );
  }
}
