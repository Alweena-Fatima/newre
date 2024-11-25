import 'package:first_app/models/quiz_model.dart';
import 'package:flutter/material.dart';

class QuizInfo extends StatelessWidget {
  const QuizInfo({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 12,
        color: Colors.white70, // Subtle text color for better readability
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Info Row
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 14,
                color: Colors.white60,
              ),
              SizedBox(width: 6),
              Text('${quiz.time} min'),
            ],
          ),
          SizedBox(height: 6),

          // Questions Info Row
          Row(
            children: [
              Icon(
                Icons.help_outline,
                size: 14,
                color: Colors.white60,
              ),
              SizedBox(width: 6),
              Text('${quiz.questions.length} Questions'),
            ],
          ),
          SizedBox(height: 6),

          // Category Info Row
          // if (quiz.category != null) // Check if category exists
          //   Row(
          //     children: [
          //       Icon(
          //         Icons.category,
          //         size: 14,
          //         color: Colors.white60,
          //       ),
          //       SizedBox(width: 6),
          //       Text(quiz.category!),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
