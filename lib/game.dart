import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;

class game extends StatefulWidget {
  game({Key? key}) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  String name = '';
  @override
  void initState() {
    firebase.collection('QuizName').get().then((QuerySnapshot) => {
          QuerySnapshot.docs.forEach((element) {
            setState(() {
              name = element['Name'];
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
    );
  }
}
