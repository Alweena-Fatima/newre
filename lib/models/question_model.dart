// ignore_for_file: public_member_api_docs, sort_constructors_first
//put question class in this

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import 'models.dart'; //import the models.dart to get the acccess of the answer class
part 'question_model.g.dart';

@HiveType(typeId: 2)
class Question {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final List<Answer> choices;

  Question({required this.text, required this.choices});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'choices': choices.map((x) => x.toMap()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'] ?? '',
      choices: List<Answer>.from(map['choices']?.map((x) => Answer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) );
}
