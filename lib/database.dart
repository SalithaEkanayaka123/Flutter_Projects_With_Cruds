import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

class Database {
  FirebaseFirestore firestore;
  FirebaseDatabase firebaseDatabase;
  DatabaseReference databaseReference;

  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String title) async {
    try {
      await firestore.collection("MyTodos").add({
        'title': title,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    print(id);
    try {
      await firestore.collection("MyTodos").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('MyTodos').get();
      print('sss');
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "title": doc['title']};

          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String title) async {
    try {
      await firestore.collection("MyTodos").doc(id).update({'title': title});
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadImage(String image) async {
    try {
      await FirebaseDatabase.instance.reference().child(image);
    } catch (e) {
      print(e);
    }
  }

  Future<List> loadAudio() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('Audio').get();
      print('sss');
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "title": doc['title'], "link": doc['link']};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }
}
