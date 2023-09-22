import 'package:flutter/material.dart';
import 'package:quizzz_appp/question.dart';
import 'package:quizzz_appp/user_answers.dart';

class Question2Screen extends StatefulWidget {
  final String nextRoute;
  final Question question;
  final UserAnswers userAnswers;
  final VoidCallback onRetry;

  Question2Screen({
    required this.nextRoute,
    required this.question,
    required this.userAnswers,
    required this.onRetry,
  });

  @override
  _Question2ScreenState createState() => _Question2ScreenState();
}

class _Question2ScreenState extends State<Question2Screen> {
  int? _selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Question 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.questionText,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ...widget.question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return Container(
                margin: EdgeInsets.only(bottom: 8.0),
                child: RadioListTile<int>(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  value: index,
                  groupValue: _selectedAnswerIndex,
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswerIndex = value;
                    });
                  },
                ),
              );
            }),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedAnswerIndex != null) {
                    widget.userAnswers.answers[1] = _selectedAnswerIndex!;
                    Navigator.pushNamed(context, widget.nextRoute);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please select an answer before proceeding.'),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
