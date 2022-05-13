import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Getuserdata extends StatelessWidget {
  final String docid;
  Getuserdata({required this.docid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "${data['name']}" + '\t\t' + 'Score: ' + "${data['highscore']}");
        } else {
          return Text("Loading...");
        }
      },
    );
  }
}
