import 'package:flutter/material.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/rendering.dart';

class SavedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'My MovieList',
          style: TextStyle(fontSize: 24),
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
                            'Action Movies',
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
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {},
      ),
    );
  }
}
