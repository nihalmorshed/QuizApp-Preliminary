import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  int? count;

  Users(
      {required this.uid, required this.name, required this.email, this.count});

  Users.fromJson(Map<dynamic, dynamic> json)
      : uid = json['uid'],
        name = json['name'] ?? 'default',
        email = json['email'] ?? 'no email',
        count = json['count'] ?? 0;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'uid': uid,
        'name': name,
        'email': email,
        // 'count': count
      };

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      // 'count': count
    };
  }

  CollectionReference userspath =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async {
    return await userspath
        .doc(uid)
        .set(toMap(), SetOptions(merge: true))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
