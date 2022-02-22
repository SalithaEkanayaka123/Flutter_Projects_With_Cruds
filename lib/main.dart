import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.orange),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  List todos = List();

  String input = "";

  createTodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyTodos").doc(input);
    Map<String, String> todos = {"todoTitle": input};

    documentReference.set(todos).whenComplete(() {
      print("$input created");
    });
  }

  Database db;
  List docs = [];
  initialise() {
    db = Database();
    db.initiliase();
    debugPrint('jjjj');
    debugPrint(db.initiliase());
    db.read().then((value) => {
          debugPrint('movieTitle4422: $value'),
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();

    todos.add("item1");
    todos.add("item2");
    todos.add("item3");
    todos.add("item4");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mytodos"),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add TodoList"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          createTodos();
                          Navigator.of(context).pop();
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
      ),

      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todos[index]),
                child: Card(
                  elevation: 4,
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
                          todos.removeAt(index);
                        });
                      },
                    ),
                  ),
                ));
          }),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
      //   builder: (context, snapshots) {
      //     return ListView.builder(
      //         shrinkWrap: true,
      //         // itemCount: snapshots.data.documents.length,
      //         itemBuilder: (context, index) {
      //           DocumentSnapshot documentSnapshot =
      //               snapshots.data.document[index];
      //           return Dismissible(
      //               key: Key(index.toString()),
      //               child: Card(
      //                 elevation: 4,
      //                 margin: EdgeInsets.all(8),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(16),
      //                 ),
      //                 child: ListTile(
      //                   title: Text(documentSnapshot["todoTitle"]),
      //                   trailing: IconButton(
      //                     icon: Icon(
      //                       Icons.delete,
      //                       color: Colors.red,
      //                     ),
      //                     onPressed: () {
      //                       setState(() {
      //                         todos.removeAt(index);
      //                       });
      //                     },
      //                   ),
      //                 ),
      //               ));
      //         });
      //   },
      // )
    );
  }
}
