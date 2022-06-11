import 'dart:math';

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
  final _random = new Random();
  int _randomindex = 0;
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
          questionsfile(questionsquiz[_randomindex = _random.nextInt(10)]
              ['questiontext'] as String),
          ...(questionsquiz[_randomindex]['answertext']
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
