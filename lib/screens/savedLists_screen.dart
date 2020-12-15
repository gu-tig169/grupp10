import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            centerTitle: true,
          ),
          body: _mylist(),
          floatingActionButton: _floatbutton(context),
        ));
  }

  final List<String> mylist = [
    'Action movies',
    'English movies',
    'Asian movies',
    'Bollywood movies',
  ];

  ListView _mylist() {
    return ListView.builder(
      itemCount: mylist.length,
      padding: EdgeInsets.all(10),
      //separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        return Card(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
            child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${mylist[index]}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'This movie category is about......',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    )),
                  ],
                )),
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
          });
        },
        label: Text('Create List'),
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
              backgroundColor: Color.fromARGB(225, 18, 18, 30).withOpacity(0.8),
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
        cursorColor: Colors.white,
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
          onPressed: () {}),
    );
  }
}
