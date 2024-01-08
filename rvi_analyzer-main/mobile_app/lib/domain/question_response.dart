import 'package:rvi_analyzer/common/key_box.dart';
import 'package:rvi_analyzer/domain/answer.dart';
import 'package:rvi_analyzer/domain/question.dart';

class QuestionResponse {
  final Question question;
  final List<Answer>? answers;

  const QuestionResponse({
    required this.question,
    this.answers,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      question: Question.fromJson(json[questionK]),
      answers: json[answersK] == null
          ? null
          : List<Answer>.from(json[answersK].map((i) => Answer.fromJson(i))),
    );
  }

  factory QuestionResponse.fromDetails(
      Question question, List<Answer> answers) {
    return QuestionResponse(
      question: question,
      answers: answers,
    );
  }
}
