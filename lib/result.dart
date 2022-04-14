import 'package:flutter/material.dart';

class result extends StatelessWidget {
  final int totalScore;
  final Function() resetHandler;
  result(this.totalScore, this.resetHandler);

  String get resultphrase {
    String txt;
    if (totalScore <= 8)
      txt = "You\'re innocent!";
    else if (totalScore <= 12)
      txt = "Pretty Likable";
    else if (totalScore <= 16)
      txt = "You\'re...strange!!";
    else
      txt = "You\'re so bad!!";

    return txt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultphrase,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
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
