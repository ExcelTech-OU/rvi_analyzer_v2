import 'package:rvi_analyzer/common/key_box.dart';

class Answer {
  final int id;
  final String questionId;
  final String answer;

  const Answer({
    required this.id,
    required this.questionId,
    required this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json[idK],
      questionId: json[questionIdK],
      answer: json[answerK],
    );
  }
}
