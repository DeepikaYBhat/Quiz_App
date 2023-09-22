import 'package:flutter/material.dart';
import 'package:quizzz_appp/question1.dart';
import 'package:quizzz_appp/question2.dart';
import 'package:quizzz_appp/question3.dart';
import 'package:quizzz_appp/result_screen.dart';
import 'package:quizzz_appp/user_answers.dart';
import 'question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserAnswers userAnswers = UserAnswers();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(
          background: const Color.fromARGB(255, 209, 209, 214),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      home: QuizHome(questions: questions),
      routes: {
        '/question1': (context) => Question1Screen(
              nextRoute: '/question2',
              question: questions[0],
              userAnswers: userAnswers,
              onRetry: () {},
            ),
        '/question2': (context) => Question2Screen(
              nextRoute: '/question3',
              question: questions[1],
              userAnswers: userAnswers,
              onRetry: () {},
            ),
        '/question3': (context) => Question3Screen(
              nextRoute: '/result',
              question: questions[2],
              userAnswers: userAnswers,
              onRetry: () {},
            ),
        '/result': (context) => FutureBuilder(
            future: calculateScores(userAnswers.answers, questions),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final userScore = snapshot.data?[0] ?? 0;
                final bestScore = snapshot.data?[1] ?? 0;
                return ResultScreen(
                  userScore: userScore,
                  bestScore: bestScore,
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      },
    );
  }

  int bestScore = 0;
  Future<List<int>> calculateScores(
      List<int?> userAnswers, List<Question> questions) async {
    await Future.delayed(Duration(seconds: 2));

    int userScore = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] != null &&
          questions[i].correctAnswerIndex == userAnswers[i]) {
        userScore++;
      }
    }

    if (userScore > bestScore) {
      bestScore = userScore;
    }
    return [userScore, bestScore];
  }
}

class QuizHome extends StatelessWidget {
  final List<Question> questions;

  QuizHome({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text('Quiz App')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/quizimg.jpg',
              width: 350,
              height: 400,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/question1');
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
