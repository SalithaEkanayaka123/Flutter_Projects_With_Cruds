import 'package:flutter/material.dart';

import 'database.dart';

class AudioFile extends StatefulWidget {
  AudioFile({Key key}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  List todos = List();
  Database db;
  List docs = [];
  initialise() {
    db = Database();
    db.initiliase();
    //change
    db.loadAudio().then((value) => {
      print(value),
          setState(() {
            
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
               key: Key(docs[index]['id']),
              child: Card(
                //elevation: u,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(docs[index]['title']),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        // todos.removeAt(index);
                        db.delete(docs[index]['id']);
                        initialise();
                      });
                    },
                  ),
                ),
              ));
        },
      ),
    );
  }
}
