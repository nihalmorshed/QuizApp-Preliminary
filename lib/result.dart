import 'package:flutter/material.dart';

class result extends StatelessWidget {
  final int totalScore;
  final Function() resetHandler;
  result(this.totalScore, this.resetHandler);

  String get resultphrase {
    String txt;
    if (totalScore <= 8)
      txt = "You\'re innocent!\n Your score is " + totalScore.toString();
    else if (totalScore <= 12)
      txt = "Pretty Likable!\n Your score is " + totalScore.toString();
    else if (totalScore <= 16)
      txt = "You\'re...strange!!\n Your score is " + totalScore.toString();
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
            onPressed: resetHandler,
            child: Text('Restart!'),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.cyanAccent),
          ),
        ],
      ),
    );
  }
}
