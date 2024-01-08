import 'package:rvi_analyzer/common/key_box.dart';

class Question {
  final int id;
  final String formFieldType;
  final String question;
  final bool enabled;

  const Question(
      {required this.id,
      required this.formFieldType,
      required this.enabled,
      required this.question});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        id: json[idK],
        formFieldType: json[formFieldTypeK],
        enabled: json[enabledK],
        question: json[questionK]);
  }
}
