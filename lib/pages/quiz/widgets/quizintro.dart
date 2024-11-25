import 'package:first_app/models/models.dart';
import 'package:first_app/pages/quiz/bloc/quiz_page_bloc.dart';
import 'package:first_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizIntro extends StatelessWidget {
  const QuizIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //this quiz will get the quiz id and quiz repo from the quiz intro page 
    Quiz quiz = context.read<QuizPageBloc>().quiz;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 147, 192, 191), // Dark mode background color
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      //   title: Text(context.watch<QuizPageBloc>().quiz.name, style: TextStyle(color: Colors.white)),
      //   elevation: 0,
      // ),
      body: Center(
        child: Card(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners for card
          ),
          color: const Color.fromARGB(255, 35, 151, 130),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure card size fits content
              children: [
                Icon(
                  Icons.quiz_rounded, // Icon for quiz section
                  size: 50,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                const SizedBox(height: 10),

                // Display Quiz Name
                Text(
                  quiz.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 10),

                // Display Quiz Description with some padding
                Text(
                  quiz.description,
                  style: TextStyle(
                    color: const Color.fromARGB(179, 0, 0, 0),
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    //: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Start Quiz Button with a modern look
                ElevatedButton.icon(
                  
                  onPressed: () {
                    context.read<QuizPageBloc>().add(StartQuiz());
                  },
                  icon: Icon(Icons.play_arrow, color: const Color.fromARGB(255, 255, 255, 255)),
                  label: Text(
                    'Start Quiz',
                    style: TextStyle(color: Colors.white),
                    
                  ),
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 42, 57, 53), // Button background color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    elevation: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
