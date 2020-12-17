import 'package:MoviePKR/models/movieList.dart';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/singleList_screen.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
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
              'My Movie Lists',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: _mylist(),
          floatingActionButton: _floatbutton(context),
        ));
  }

  final List<String> mylist = [
    'Movies to watch with kids',
    'Movies I Hate',
    'All-times best',
    'Williams best Bollywood',
  ];

  //William for add en lsit
  TextEditingController textEditingController;
  String listTitle;

  //William setTextController
  void setTextController() {
    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        if (textEditingController.text != null &&
            textEditingController.text != '') {
          listTitle = textEditingController.text;
        }
      });
    });
  }

  ListView _mylist() {
    final snapshot = Provider.of<MovieLists>(context, listen: false);
    var list = snapshot.movieLists;

    return ListView.builder(
      itemCount: list.length,
      padding: EdgeInsets.all(10),
      //separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        return Card(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: FlatButton(
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => new MovieListScreen()))
              },
              child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: SizedBox(
                          width: 75,
                          height: double.infinity,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                snapshot.movieLists[index].listTitle,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            Text(
                              snapshot.movieLists[index].count.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  //This widget is for FloatingActionButton
  Widget _floatbutton(BuildContext context) {
    return Container(
      width: 130,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.thirdColor,
        icon: Icon(Icons.add, color: Colors.white, size: 20),
        onPressed: () {
          setState(() {
            show();

            //William
            setTextController();
          });
        },
        label: Text('New List'),
      ),
    );
  }

//The "create list" popup window where you can create new list by typing in a name of the list.
  void show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              backgroundColor:
                  Color.fromARGB(225, 18, 18, 30).withOpacity(0.95),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'Create a Movie List',
                style: TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              content: _textInputField(),
              actions: <Widget>[
                _addListButton(),
              ]);
        });
  }

  Widget _textInputField() {
    return TextField(
        //William. set controll to TextField
        maxLength: 30,
        maxLengthEnforced: true,
        controller: textEditingController,
        //

        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
          border: const OutlineInputBorder(),
          labelText: 'List Name',
        ));
  }

  Widget _addListButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 100, left: 100),
      child: FlatButton.icon(
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          color: AppColors.thirdColor,
          icon: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 15.0,
          ),
          label: Text(
            'ADD',
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              if (listTitle != null && listTitle != '') {
                //replace this provider with real code.
                Provider.of<MovieLists>(context, listen: false)
                    .movieLists
                    .add(new MovieList(listTitle));

                //clear the text. William
                textEditingController.text = '';
                listTitle = '';

                //Don 't remove this.
                Navigator.of(context, rootNavigator: true)
                    .pop(); //Dismiss the dialog

              }
            });
          }),
    );
  }
}
