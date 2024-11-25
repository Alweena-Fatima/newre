import 'package:first_app/pages/quiz/bloc/quiz_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Quizfinsihed extends StatelessWidget {
  const Quizfinsihed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Read the score from QuizPageBloc
    int score = context.read<QuizPageBloc>().state.score;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 120, 122), // Adjusted to match QuizInProgress background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Small Card for Finish Info
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Trophy Icon for Achievement
                      Icon(
                        Icons.emoji_events,
                        size: 80,
                        color: Colors.amber,
                      ),
                      SizedBox(height: 10),

                      // Congratulations Message
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Quiz Finish Message
                      Text(
                        'You have finished the quiz.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Centered Score Message
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            // Score label with Icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.sports_score_outlined,
                                  color: const Color.fromARGB(255, 57, 120, 122),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Your Score:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Score value in a large font
                            Text(
                              '$score',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 57, 120, 122),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // End Quiz Button
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the home page
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'End Quiz',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
