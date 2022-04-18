import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';
import './result.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;

class game extends StatefulWidget {
  game({Key? key}) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
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

  String name = '';
  @override
  void initState() {
    firebase.collection('QuizName').get().then((QuerySnapshot) => {
          QuerySnapshot.docs.forEach((element) {
            setState(() {
              name = element['Name'];
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ji le Apni Jindegi'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: _question_index < _questions.length
            ? quiz(
                answersquiz: _answers,
                question_indexquiz: _question_index,
                questionsquiz: _questions,
              )
            : result(_totalscore, _resetquiz),
      ),
    );
  }
}
