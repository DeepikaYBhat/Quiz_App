import 'package:quizzz_appp/user_answers.dart';

int userScore = 0;

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<Question> questions = [
  Question(
    questionText: "What was the day of the week on 28th May, 2006?",
    options: ["Thursday", "Friday", "Saturday", "Sunday"],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText:
        "It was Sunday on Jan 1, 2006. What was the day of the week Jan 1, 2010?",
    options: ["Sunday", "Saturday", "Friday", "Wednesday"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Today is Monday. After 61 days, it will be: ",
    options: ["Wednesday", "Saturday", "Tuesday", "Thursday"],
    correctAnswerIndex: 1,
  ),
];

// Initialize UserAnswers here
final UserAnswers userAnswers = UserAnswers();
