// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'answer_model.g.dart';

@HiveType(typeId: 3)
//put the answer part/class in this
class Answer {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool correct;
  @HiveField(2)
  final String feedback;
  Answer({
    required this.text,
    required this.correct,
    this.feedback = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'correct': correct,
      'feedback': feedback,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      text: map['text'] as String,
      correct: map['correct'] as bool,
      feedback: map['feedback'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));
}
//we need a way of converting to/from jason less to jason using extension we'hv installed (ctrl+. ---> generate jason)
