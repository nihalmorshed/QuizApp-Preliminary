import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/game.dart';
import './topics_cricket.dart';

class topics extends StatelessWidget {
  const topics({Key? key}) : super(key: key);
  startgame(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => game()),
    );
  }

  topics_cricket(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => cricket()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Topics',
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
                'Choose Your Topic',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    startgame(context);
                  },
                  child: Text(
                    'Fifa World Cup 2022',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    topics_cricket(context);
                  },
                  child: Text(
                    'Cricket',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
