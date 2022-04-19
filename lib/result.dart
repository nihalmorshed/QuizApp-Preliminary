import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/home.dart';

class result extends StatelessWidget {
  final int totalScore;
  final Function() resetHandler;
  result(this.totalScore, this.resetHandler);

  String get resultphrase {
    String txt;
    if (totalScore >= 50)
      txt = "You\'re  pretty Good!\n Your score is " + totalScore.toString();
    else if (totalScore >= 40)
      txt = "Not Bad!\n Your score is " + totalScore.toString();
    else if (totalScore >= 30)
      txt = "There's scope for improvement!!\n Your score is " +
          totalScore.toString();
    else
      txt = "You\'re so bad!!\n Your score is " + totalScore.toString();

    return txt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Text(
              resultphrase,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
            child: Text(
              'Restart!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.white),
          ),
        ],
      ),
    );
  }
}
