import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/login.dart';
import 'package:flutter_complete_guide/profile.dart';
import 'package:flutter_complete_guide/topics.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);
  startgame(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => topics()),
    );
  }

  leader(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => profile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Welcome!',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Your Options',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    startgame(context);
                  },
                  child: Text(
                    'Start!',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    leader(context);
                  },
                  child: Text(
                    'Leaderboard!',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              OutlineButton(
                borderSide: BorderSide(color: Colors.orange),
                child: Text(
                  'Log-Out',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginregister()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
