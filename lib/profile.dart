import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestoreInstance = FirebaseFirestore.instance;
String name = '';
int highscore = 0;
int rank = 0;

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Future<void> fetch() async {
    var firebaseUser = FirebaseAuth.instance.currentUser!.uid;
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser)
        .get()
        .then((value) {
      print(value.data());
      setState(() {
        name = value.data()!["name"].toString();
        highscore = value.data()!["highscore"] ?? -1;
      });
    });
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> docIds = [];

  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // Stack(
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundImage: NetworkImage(
                  //           "https://images.unsplash.com/photo-1635107510862-53886e926b74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1935&q=80"),
                  //       radius: 50,
                  //     ),
                  //     Positioned(
                  //       bottom: 0,
                  //       right: 0,
                  //       child: Container(
                  //         padding: EdgeInsets.all(2),
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle, color: Colors.white),
                  //         child: Icon(
                  //           Icons.edit,
                  //           color: Colors.teal,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            rank.toString(),
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                          Text(
                            "Rank",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            highscore.toString(),
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                          Text(
                            "High Score",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "LeaderBoard",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.all(22),
              child: SizedBox(
                height: 400,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .orderBy('highscore', descending: true)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      docIds = snapshot.data!.docs;
                      // docIds.sort();

                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docIds[i].data();
                          if (name == data['name']) {
                            rank = i + 1;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              tileColor: Colors.blueGrey,
                              leading: Text(
                                "#" + (i + 1).toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              title: Text(data['name']),
                              trailing: Text(
                                  "Score: " + data['highscore'].toString()),
                            ),
                          );
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
