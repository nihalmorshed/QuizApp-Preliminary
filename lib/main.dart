import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_complete_guide/home.dart';
import 'package:flutter_complete_guide/profile.dart';
import './login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Myappstate();
  }
}

class _Myappstate extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return loginregister();
    return MaterialApp(
      home: homescreen(),
    );
  }
}
