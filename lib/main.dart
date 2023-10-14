import 'dart:core';
import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

    List<Icon> scoreKeeper =[];

    void checkAnswer(bool userPickedAnswer){
      bool correctAns = quizBrain.getCorrectAnswer();

      setState(() {
        if(quizBrain.isFinished() == true){
          Alert(
            context: context,
            title: 'Finished!',
            desc:'You\'ve reached the end of Quiz',
          ).show();

          quizBrain.reset();

          scoreKeeper=[];
        }
        else{
          if(userPickedAnswer ==  correctAns){
            scoreKeeper.add(Icon(Icons.check,color: Colors.green));
          }else{
            scoreKeeper.add(Icon(Icons.close,color: Colors.red));
          }

          quizBrain.nextQuestion();
        }
      });
    }

    // List<String> questions = [
    //   'You can lead a cow down stairs but not up stairs.',
    //   'Approximately one quarter of human bones are in the feet.',
    //   'A slug\'s blood is green.'
    // ];
    //
    // List<bool> ans = [false,true,true];
    //
    // Question q1 = Question(q: 'You can lead a cow down stairs but not up stairs.', a: false);
    // Question q2 = Question(q: 'Approximately one quarter of human bones are in the feet.', a: true);
    // Question q3 = Question(q: 'A slug\'s blood is green.', a: true);


    int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
