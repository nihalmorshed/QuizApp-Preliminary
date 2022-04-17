import 'package:flutter/material.dart';

class homescreen extends StatelessWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome!'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Your Options',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Start!',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
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
                  onPressed: () {},
                  child: Text(
                    'Leaderboard!',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
