import 'package:flutter/material.dart';
import './questionsfile.dart';
import './answersfile.dart';

class quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answers;
  final int question_index;

  quiz({
    required this.answers,
    required this.questions,
    required this.question_index,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionsfile(questions[question_index]['questiontext'] as String),
        ...(questions[question_index]['answertext']
                as List<Map<String, Object>>)
            .map((ans) {
          return Answers(() => answers(ans['score']), ans['text'] as String);
        }).toList()
      ],
    );
  }
}
