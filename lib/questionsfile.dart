import 'package:flutter/cupertino.dart';

class questionsfile extends StatelessWidget {
  final String ques;
  questionsfile(this.ques);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Text(
        ques,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
