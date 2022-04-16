import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/result.dart';
import './questionsfile.dart';
import './answersfile.dart';
import './quiz.dart';
import './result.dart';
import './login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Myappstate();
  }
}

class _Myappstate extends State<MyApp> {
  static const _questions = [
    {
      'questiontext': 'What\'s ur favourite Color!?',
      'answertext': [
        {'text': 'Red', 'score': 6},
        {'text': 'Green', 'score': 3},
        {'text': 'Blue', 'score': 10},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questiontext': 'What\'s ur favourite Food!?',
      'answertext': [
        {'text': 'Meat', 'score': 3},
        {'text': 'Fish', 'score': 11},
        {'text': 'Vegies', 'score': 5},
        {'text': 'Chicken', 'score': 9},
      ],
    },
    {
      'questiontext': 'Who\'s ur favourite Superhero!?',
      'answertext': [
        {'text': 'SpiderMan', 'score': 10},
        {'text': 'Batman', 'score': 9},
        {'text': 'Superman', 'score': 5},
        {'text': 'Ironman', 'score': 7}
      ],
    },
  ];
  var _question_index = 0;
  var _totalscore = 0;

  void _resetquiz() {
    setState(() {
      _question_index = 0;
      _totalscore = 0;
    });
  }

  void _updtqindex() {
    _question_index++;
    print(_question_index);
  }

  void _answers(int score) {
    _totalscore += score;
    setState(() {
      _updtqindex();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  return loginregister();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First Flutter Application'),
        ),
        body: _question_index < _questions.length
            ? quiz(
                answers: _answers,
                question_index: _question_index,
                questions: _questions,
              )
            : result(_totalscore, _resetquiz),
      ),
    );
  }
}
