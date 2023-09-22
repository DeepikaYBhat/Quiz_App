import 'package:flutter/material.dart';
import 'package:quizzz_appp/question.dart';
import 'package:quizzz_appp/user_answers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatelessWidget {
  final int userScore;
  int bestScore = 0;
  int previousScore = 0;

  ResultScreen({
    required this.userScore,
    required this.bestScore,
  });

  @override
  Widget build(BuildContext context) {
    int updatedBestScore = userScore > bestScore ? userScore : bestScore;

    _updateBestScore(updatedBestScore);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text('Result')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score: $userScore',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Best Score: $updatedBestScore',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text(
                  'Retry Quiz',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateBestScore(int updatedBestScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', updatedBestScore);
  }
}

int calculateUserScore(UserAnswers userAnswers, List<Question> questions) {
  int userScore = 0;
  for (int i = 0; i < questions.length; i++) {
    if (userAnswers.answers[i] == questions[i].correctAnswerIndex) {
      userScore++;
    }
  }
  return userScore;
}

Future<int> loadBestScore() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('bestScore') ?? 0;
}
