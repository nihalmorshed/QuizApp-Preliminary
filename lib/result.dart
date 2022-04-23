import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/home.dart';

final firestoreInstance = FirebaseFirestore.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;
String name = '';
int score = 0;

class result extends StatefulWidget {
  final int totalScore;
  final Function() resetHandler;
  result(this.totalScore, this.resetHandler);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  void fetch() {
    var firebaseUser = FirebaseAuth.instance.currentUser!.uid;
    firestoreInstance.collection("users").doc(firebaseUser).get().then((value) {
      print(value.data());
      setState(() {
        name = value.data()!["name"].toString();
        score = value.data()!["score"];
      });
    });
  }

  Future<void> push() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await firestoreInstance.collection("users").doc(firebaseUser?.uid).set({
      "uid": firebaseUser?.uid,
      "score": widget.totalScore,
    }, SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  String get resultphrase {
    String txt;
    push();
    if (widget.totalScore >= 120) {
      fetch();
      txt = "Congratulations! " +
          name +
          "\nYou\'re  pretty Good!\n Your score is " +
          score.toString() +
          " Out of " +
          160.toString();
    } else if (widget.totalScore >= 100)
      txt = "Not Bad! " +
          name +
          " Your score is " +
          widget.totalScore.toString() +
          " Out of " +
          160.toString();
    else if (widget.totalScore >= 60)
      txt = "Take ur time!! " +
          name +
          " There's scope for improvement!!\n Your score is " +
          widget.totalScore.toString() +
          " Out of " +
          160.toString();
    else
      txt = "Such a shame, " +
          name +
          "\nYou\'re so bad!! Your score is " +
          widget.totalScore.toString() +
          " Out of " +
          160.toString();

    return txt;
  }

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
