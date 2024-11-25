import 'package:first_app/models/quiz_model.dart';
import 'package:first_app/pages/quiz/quizpage.dart';
import 'package:first_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Quizpage(quizId: quiz.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 27, 26, 28), Color.fromARGB(255, 88, 186, 183)], // Gradient effect
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              color: Colors.black26,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz Image with Rounded Corners
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: quiz.id,
                child: QuizImage(
                  url: quiz.imageUrl,
                  width: 90,
                  height: 90,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Quiz Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Quiz Name
                  Text(
                    quiz.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Quiz Description
                  Text(
                    quiz.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(179, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Quiz Info Widget
                  QuizInfo(quiz: quiz),
                ],
              ),
            ),

            // Forward Icon
            Icon(
              Icons.arrow_forward_ios,
              color: const Color.fromARGB(179, 0, 0, 0),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
