import 'package:MoviePKR/screens/movieDescription/widgets/setup_alert_diaload_container.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

class AddToListBtn extends StatefulWidget {
  final int id;
  AddToListBtn({Key key, this.id}) : super(key: key);

  @override
  _AddToListBtnState createState() => _AddToListBtnState();
}

class _AddToListBtnState extends State<AddToListBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            child: FloatingActionButton.extended(
                heroTag: "btn1",
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
                          return SetupAlertDialoadContainer();
                        });
                  });
                })),
      ]),
    );
  }
}
