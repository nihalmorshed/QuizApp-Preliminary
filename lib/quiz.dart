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
    return Column(
      children: [
        questionsfile(
            questionsquiz[question_indexquiz]['questiontext'] as String),
        ...(questionsquiz[question_indexquiz]['answertext']
                as List<Map<String, Object>>)
            .map((ans) {
          return Answers(
              () => answersquiz(ans['score']), ans['text'] as String);
        }).toList()
      ],
    );
  }
}
