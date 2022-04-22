import 'package:flutter/material.dart';
import './questionsfile.dart';
import './answersfile.dart';

class quiz extends StatelessWidget {
  final List<Map<String, Object>> questionsquiz;
  final Function answersquiz;
  final int question_indexquiz;

  quiz({
    required this.answersquiz,
    required this.questionsquiz,
    required this.question_indexquiz,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Question: " + (question_indexquiz + 1).toString(),
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          questionsfile(
              questionsquiz[question_indexquiz]['questiontext'] as String),
          ...(questionsquiz[question_indexquiz]['answertext']
                  as List<Map<String, Object>>)
              .map((ans) {
            return Answers(
                () => answersquiz(ans['score']), ans['text'] as String);
          }).toList()
        ],
      ),
    );
  }
}
