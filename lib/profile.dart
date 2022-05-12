import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/getusername.dart';

final firestoreInstance = FirebaseFirestore.instance;
String name = '';
int highscore = 0;

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

  List<String> docIds = [];

  Future getdocIds() async {
    FirebaseFirestore.instance
        .collection("users")
        .orderBy('highscore', descending: true)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        print(element.reference);
        docIds.add(element.reference.id);
      });
    });
    fetch();
  }

  @override
  Widget build(BuildContext context) {
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
                            "45",
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                          Text(
                            "Level",
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
                            "#335",
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
                child: FutureBuilder(
                  future: getdocIds(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                            title: Row(
                              children: [
                                // CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //       "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80"),
                                // ),

                                Getuserdata(docid: docIds[index]),
                                // Text(docIds[index]),
                              ],
                            ),
                            tileColor: Colors.blueGrey,
                            leading: Text(
                              "#" + (index + 1).toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // trailing: Text(" 100",
                            //     style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );
                      },
                      itemCount: docIds.length,
                    );
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
