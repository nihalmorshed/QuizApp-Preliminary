import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';
import './result.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class game extends StatefulWidget {
  game({Key? key}) : super(key: key);

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  static const _questions = [
    {
      'questiontext': 'Which country hosted the 2018 World Cup?',
      'answertext': [
        {'text': 'Russia', 'score': 10},
        {'text': 'Brazil', 'score': 0},
        {'text': 'France', 'score': 0},
        {'text': 'Germany', 'score': 0},
      ],
    },
    {
      'questiontext':
          'Which team will arrive at the tournament as the reigning champions?',
      'answertext': [
        {'text': 'Germany', 'score': 0},
        {'text': 'France', 'score': 10},
        {'text': 'England', 'score': 0},
        {'text': 'Brazil', 'score': 0},
      ],
    },
    {
      'questiontext': 'Which of the following is not an official FIFA partner?',
      'answertext': [
        {'text': 'Adidas', 'score': 0},
        {'text': 'Budweiser', 'score': 10},
        {'text': 'Visa', 'score': 0},
        {'text': 'Coca-Cola', 'score': 0}
      ],
    },
    {
      'questiontext': 'Which countries will host the 2026 World Cup?',
      'answertext': [
        {'text': 'USA', 'score': 0},
        {'text': 'USA and Mexico', 'score': 0},
        {'text': 'USA and Canada', 'score': 0},
        {'text': 'USA, Mexico and Canada', 'score': 10}
      ],
    },
    {
      'questiontext': 'How many previous World Cups have there been?',
      'answertext': [
        {'text': '18', 'score': 0},
        {'text': '19', 'score': 0},
        {'text': '20', 'score': 0},
        {'text': '21', 'score': 10}
      ],
    },
    {
      'questiontext': 'Which stadium has the highest capacity?',
      'answertext': [
        {'text': 'Al Bayt Stadium', 'score': 0},
        {'text': 'Lusail Iconic Stadium', 'score': 10},
        {'text': 'Education City Stadium', 'score': 0},
        {'text': 'Al Rayyan Stadium', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Which was the only FIFA World Cup tournament not to have a Final match?',
      'answertext': [
        {'text': '1950 in Brazil', 'score': 10},
        {'text': '1994 in United States', 'score': 0},
        {'text': ' 1986 in Mexico', 'score': 0},
        {'text': '1978 in Argentina', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Who was the only manager to win the FIFA World Cup twice?',
      'answertext': [
        {'text': 'Aymoré Moreira', 'score': 0},
        {'text': 'Luiz Felipe Scolari', 'score': 0},
        {'text': 'Franz Beckenbauer', 'score': 0},
        {'text': 'Vittorio Pozzo of Italy', 'score': 10}
      ],
    },
    {
      'questiontext':
          'Who won the Golden Boot at the 2018 World Cup in Russia?',
      'answertext': [
        {'text': 'Cristiano Ronaldo, Portugal', 'score': 0},
        {'text': 'Antoine Griezmann, France', 'score': 0},
        {'text': 'Romelu Lukaku, Belgium', 'score': 0},
        {'text': 'Harry Kane, England', 'score': 10}
      ],
    },
    {
      'questiontext': 'How many world cup finals have been won on penalties?',
      'answertext': [
        {'text': 'One', 'score': 0},
        {'text': 'Two', 'score': 10},
        {'text': 'Three', 'score': 0},
        {'text': 'Four', 'score': 0}
      ],
    },
    {
      'questiontext': 'Who has scored the most goals in World Cup history?',
      'answertext': [
        {'text': 'Gerd Müller, Germany', 'score': 0},
        {'text': 'Miroslav Klose, Germany', 'score': 10},
        {'text': 'Ronaldo, Brazil', 'score': 0},
        {'text': 'Pele, Brazil', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Luis Suarez was caught on camera biting the shoulder of which player in 2014?',
      'answertext': [
        {'text': 'Giorgio Chiellini, Italy', 'score': 10},
        {'text': 'Leonardo Bonucci, Italy', 'score': 0},
        {'text': 'Ciro Immobile, Italy', 'score': 0},
        {'text': 'Lorenzo Insigne, Italy', 'score': 0}
      ],
    },
    {
      'questiontext': 'Who scored the World Cup\'s first VAR goal?',
      'answertext': [
        {'text': 'Romelu Lukaku, Belgium', 'score': 0},
        {'text': 'Denis Cheryshev, Russia', 'score': 0},
        {'text': 'Antoine Griezmann, France', 'score': 10},
        {'text': 'Luka Modric, Croatia ', 'score': 0}
      ],
    },
    {
      'questiontext': 'Which team has played maximum FIFA final?',
      'answertext': [
        {'text': 'Germany ', 'score': 10},
        {'text': 'England', 'score': 0},
        {'text': 'Brazil', 'score': 0},
        {'text': 'Italy', 'score': 0}
      ],
    },
    {
      'questiontext': 'Who design FIFA cup tournament format?',
      'answertext': [
        {'text': 'Óscar Míguez', 'score': 0},
        {'text': 'Guillermo Stábile', 'score': 0},
        {'text': 'Landon Donovan', 'score': 0},
        {'text': 'Silvio Gazzaniga', 'score': 10}
      ],
    },
    {
      'questiontext': ' Most Successful FIFA Cup Team?',
      'answertext': [
        {'text': 'Argentina', 'score': 0},
        {'text': 'Germany', 'score': 0},
        {'text': 'Italy', 'score': 0},
        {'text': 'Brazil', 'score': 10}
      ],
    },
  ];
  var _question_index = 0;
  var _totalscore = 0;
  var _quesCount = 0;

  void _resetquiz() {
    setState(() {
      _question_index = 0;
      _totalscore = 0;
    });
  }

  void _updtqindex() {
    _question_index++;
    _quesCount++;
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
    firestore.collection('QuizName').get().then((QuerySnapshot) => {
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
          title: Text(
              //name
              "The World Cup Quiz"),
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
