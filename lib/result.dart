import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/home.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
String name = '';
int score = 0;

class result extends StatelessWidget {
  final int totalScore;
  final Function() resetHandler;
  result(this.totalScore, this.resetHandler);

  void fetch() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("users")
        .doc(firebaseUser?.uid)
        .get()
        .then((value) {
      print(value.data());
      name = value.data()![firebaseUser?.uid.toString()]["name"];
      score = value.data()![firebaseUser?.uid.toString()]["score"];
    });
  }

  void push() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(firebaseUser?.uid).set({
      "uid": firebaseUser?.uid,
      "score": totalScore,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  String get resultphrase {
    String txt;
    push();
    if (totalScore >= 80) {
      fetch();
      txt = name +
          "\nYou\'re  pretty Good!\n Your score is " +
          score.toString() +
          " Out of " +
          160.toString();
    } else if (totalScore >= 60)
      txt = "Not Bad!\n Your score is " +
          totalScore.toString() +
          " Out of " +
          160.toString();
    else if (totalScore >= 50)
      txt = "There's scope for improvement!!\n Your score is " +
          totalScore.toString() +
          " Out of " +
          160.toString();
    else
      txt = "You\'re so bad!!\n Your score is " +
          totalScore.toString() +
          " Out of " +
          160.toString();

    return txt;
  }

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Text(
              resultphrase,
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // resetHandler;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homescreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Text(
                'Return to Home!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.black),
          ),
        ],
      ),
    );
  }
}
