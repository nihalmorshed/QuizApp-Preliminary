import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/quiz.dart';
import './result.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class cricket extends StatefulWidget {
  cricket({Key? key}) : super(key: key);

  @override
  State<cricket> createState() => _cricketState();
}

class _cricketState extends State<cricket> {
  static const _questions = [
    {
      'questiontext':
          ' How many individual centuries have been scored in World Cup finals so far?',
      'answertext': [
        {'text': 'Five', 'score': 0},
        {'text': 'Six', 'score': 10},
        {'text': 'Seven', 'score': 0},
        {'text': 'Eight', 'score': 0},
      ],
    },
    {
      'questiontext':
          'Who remains the only captain to have not gotten a chance to bat in a World Cup final so far?',
      'answertext': [
        {'text': 'Steve Waugh', 'score': 10},
        {'text': 'Ian Chappell', 'score': 0},
        {'text': 'Wasim Akram', 'score': 0},
        {'text': 'Graham Gooch', 'score': 0},
      ],
    },
    {
      'questiontext':
          'Which edition holds the record for the most maidens in a World Cup final?',
      'answertext': [
        {'text': '1979', 'score': 0},
        {'text': '1975', 'score': 0},
        {'text': '1983', 'score': 10},
        {'text': '1987', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Which bowler holds the unwanted record for the most expensive figures in a World Cup final?',
      'answertext': [
        {'text': 'Dilhara Fernando, Sri-lanka', 'score': 0},
        {'text': 'Trent Boult, Newzealand', 'score': 0},
        {'text': 'Nuwan Kulasekara, Sri-lanka', 'score': 0},
        {'text': 'Javagal Srinath, India', 'score': 10}
      ],
    },
    {
      'questiontext':
          'Which of the following Hollywood movies was Dale Steyn a part of?',
      'answertext': [
        {'text': 'Deadpool', 'score': 0},
        {'text': 'Avengers', 'score': 0},
        {'text': 'Blended', 'score': 10},
        {'text': 'Spider Man', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Which was the first non Test playing nation to defeat a Test team in an ODI?',
      'answertext': [
        {'text': 'South Africa', 'score': 0},
        {'text': 'Canada', 'score': 0},
        {'text': 'Zimbabwe', 'score': 0},
        {'text': 'Sri Lanka', 'score': 10}
      ],
    },
    {
      'questiontext':
          'Which was the first team to defeat West Indies in a World Cup game?',
      'answertext': [
        {'text': 'Pakistan', 'score': 0},
        {'text': 'India', 'score': 10},
        {'text': ' England', 'score': 0},
        {'text': 'Sri Lanka', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Whose record did Younis Khan break to become Pakistan\'s highest run-getter in Tests?',
      'answertext': [
        {'text': 'Javed Miandad', 'score': 10},
        {'text': 'Zaheer Abbas', 'score': 0},
        {'text': 'Inzamam-ul-Haq', 'score': 0},
        {'text': 'Saleem Malik', 'score': 0}
      ],
    },
    {
      'questiontext':
          'How many substitutes can each team be allowed in Test cricket?',
      'answertext': [
        {'text': 'Four', 'score': 0},
        {'text': 'Five', 'score': 0},
        {'text': 'Six', 'score': 10},
        {'text': 'No limit', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Sachin Tendulkar has more five-wicket hauls in ODIs than which of these legendary bowlers?',
      'answertext': [
        {'text': 'Glenn McGrath', 'score': 0},
        {'text': 'Shane Warne', 'score': 10},
        {'text': 'Muttiah Muralitharan', 'score': 0},
        {'text': 'Curtly Ambrose', 'score': 0}
      ],
    },
    {
      'questiontext': 'In which year was the first ICC Women’s World Cup held?',
      'answertext': [
        {'text': '1978', 'score': 0},
        {'text': '1973', 'score': 10},
        {'text': '1993', 'score': 0},
        {'text': '2005', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Which of the following players do not have a T20 World Cup hat-trick?',
      'answertext': [
        {'text': 'KAGISO RABADA', 'score': 0},
        {'text': 'Lasith Malinga', 'score': 10},
        {'text': 'Brett Lee', 'score': 0},
        {'text': 'Wanindu Hasaranga', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Sachin Tendulkar has made Test hundreds in all Test playing nations except one. Name the country?',
      'answertext': [
        {'text': 'Bangladesh', 'score': 0},
        {'text': 'Pakistan', 'score': 0},
        {'text': 'Zimbabwe', 'score': 10},
        {'text': 'New Zealand', 'score': 0}
      ],
    },
    {
      'questiontext':
          'Which player holds the record for the fastest fifty in a T20WC final?',
      'answertext': [
        {'text': 'Mitchell Marsh ', 'score': 10},
        {'text': 'Kane Williamson', 'score': 0},
        {'text': 'Yuvraj Singh', 'score': 0},
        {'text': 'David Warner', 'score': 0}
      ],
    },
    {
      'questiontext':
          'In which year over his 24-year career did Sachin Tendulkar score the most number of Test centuries?',
      'answertext': [
        {'text': '1997', 'score': 0},
        {'text': '1998', 'score': 0},
        {'text': '1999', 'score': 0},
        {'text': '2010', 'score': 10}
      ],
    },
    {
      'questiontext':
          ' What is the total number of ways in which a player can be out in a game of cricket as per the MCC Laws?',
      'answertext': [
        {'text': '9', 'score': 0},
        {'text': '10', 'score': 10},
        {'text': '11', 'score': 0},
        {'text': '12', 'score': 0}
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
            "The Cricket Quiz",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.orange,
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
