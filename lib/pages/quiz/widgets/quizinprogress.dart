import 'dart:async';

// import 'package:first_app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/models/models.dart';
import 'package:first_app/pages/quiz/bloc/quiz_page_bloc.dart';

class QuizInProgress extends StatefulWidget {
  const QuizInProgress({Key? key}) : super(key: key);

  @override
  _QuizInProgressState createState() => _QuizInProgressState();
}

class _QuizInProgressState extends State<QuizInProgress> {
  late Timer _timer;
  int _timeRemaining = 30; // Time for each question

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeRemaining = 30; // Reset the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _moveToNextQuestion();
      }
    });
  }

  void _moveToNextQuestion() {
    // Cancel the timer and trigger the next question event
    _timer.cancel();
    context.read<QuizPageBloc>().add(NextQuestion());
    _startTimer(); // Restart timer for the next question
  }

  @override
  Widget build(BuildContext context) {
    QuizPageBloc quizPageBloc = context.watch<QuizPageBloc>();
    Quiz quiz = quizPageBloc.quiz;
    Question question = quiz.questions[quizPageBloc.state.questionNumber];

    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 57, 120, 122), // Set your desired background color here
     // appBar: QuizPageAppBar(), // Include your app bar
      body: BlocBuilder<QuizPageBloc, QuizPageState>(
        
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 20),
              // Timer Display
              Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Time Remaining: $_timeRemaining seconds',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 171, 212, 200),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Stack(
                    children: [
                      // Background Line
                      Container(
                        height: 8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Foreground Line that shrinks over time
                      FractionallySizedBox(
                        widthFactor: _timeRemaining / 30,
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Question Display
              Container(
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 35, 151, 130),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Question ${state.questionNumber + 1}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      question.text,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Options List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: question.choices.length,
                  itemBuilder: (context, index) {
                    Answer choice = question.choices[index];
                    return AnswerTile(
                      index: index,
                      choice: choice,
                    );
                  },
                ),
              ),
              // Next Button (only appears after an answer is selected)
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<QuizPageBloc, QuizPageState>(
                    builder: (context, state) {
                      if (state.answerStatus.isUnanswered) {
                        return const SizedBox();
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.answerStatus.isCorrect
                                ? Colors.blue
                                : Colors.red,
                          ),
                          onPressed: () {
                            _timer.cancel(); // Cancel the timer when moving to the next question
                            quizPageBloc.add(NextQuestion());
                            _startTimer(); // Restart the timer for the next question
                          },
                          child: const Text('Next'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
class AnswerTile extends StatelessWidget {
  const AnswerTile({
    Key? key,
    required this.index,
    required this.choice,
  }) : super(key: key);

  final int index;
  final Answer choice;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizPageBloc, QuizPageState>(
      builder: (context, state) {
        // Check if this option is selected
        bool selected = index == state.answerIdx;

        // Determine the icon and feedback text based on correctness
        Icon icon = Icon(
          selected
              ? (state.answerStatus.isCorrect
                  ? Icons.check_circle
                  : Icons.close)
              : Icons.circle_outlined,
          color: selected
              ? (state.answerStatus.isCorrect ? Colors.green : Colors.red)
              : Colors.grey,
        );

        String feedback = '';
        if (selected) {
          if (state.answerStatus.isCorrect) {
            feedback = choice.feedback.isNotEmpty
                ? choice.feedback
                : 'That is correct! +10 points.';
          } else {
            feedback = choice.feedback.isNotEmpty
                ? choice.feedback
                : 'That is not correct. Try harder next time!';
          }
        }

        return GestureDetector(
          onTap: () {
            if (state.answerStatus.isUnanswered) {
              // Only process answer if it's not already selected
              context.read<QuizPageBloc>().add(
                    AnswerQuestion(
                      isCorrect: choice.correct,
                      answerIdx: index,
                    ),
                  );
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selected
                  ? (state.answerStatus.isCorrect
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2))
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? (state.answerStatus.isCorrect ? Colors.green : Colors.red)
                    : Colors.grey,
                width: 1.5,
              ),
              boxShadow: [
                if (selected)
                  BoxShadow(
                    color: (state.answerStatus.isCorrect
                            ? Colors.green
                            : Colors.red)
                        .withOpacity(0.3),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Answer text
                Row(
                  children: [
                    icon,
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        choice.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                // Feedback text
                if (selected)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      feedback,
                      style: TextStyle(
                        fontSize: 14,
                        color: state.answerStatus.isCorrect
                            ? const Color.fromARGB(255, 47, 89, 153)
                            : const Color.fromARGB(255, 89, 255, 0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
} 