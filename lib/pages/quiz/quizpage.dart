import 'package:first_app/models/quiz_model.dart';
import 'package:first_app/pages/quiz/bloc/quiz_page_bloc.dart';
import 'package:first_app/pages/quiz/widgets/quizfinsihed.dart';
import 'package:first_app/pages/quiz/widgets/quizinprogress.dart';
import 'package:first_app/pages/quiz/widgets/quizintro.dart';
import 'package:first_app/repositories/quiz_repository.dart';
import 'package:first_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Quizpage extends StatelessWidget {
  final String
      quizId; //this will give the cureent clicked quiz id that user has
  const Quizpage({Key? key, required this.quizId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Quiz quiz = context.read<QuizRepository>().getQuiz(quizId);

    //ye getquizid class in quiz repository ko call kar raha hai ussme user jo quiz click karega usska id bhej raha hai
    return BlocProvider(
      //bloc provider creates the quiz page block and passes it everything that we need
      //here we are creating the quiz block and passing the quiz repository into quiz repository
      //also adding an event to that bloac of load quiz
      create: (context) => QuizPageBloc(
        // quiz: context.read<QuizRepository>(),
        quiz: quiz,
      )..add(LoadPage(quizId: quizId)), //load the initial page
      child: Scaffold(
          extendBodyBehindAppBar: true,
          //now extract the app bar to put in diff quiz name
          appBar: QuizPageAppBar(),
          body: Stack(
            children: [
              //this hero is goving the background image while quiz in progress
              // Hero(
              //   tag: quiz.id,
              //   child: QuizImage(
              //     url: quiz.imageUrl,
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height,
              //   ),
              // ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  // child: Container(
                  //   margin: const EdgeInsets.only(bottom: 20),padding: const EdgeInsets.all(20),
                  //   width: MediaQuery.of(context).size.width*.8,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color.fromARGB(255, 255, 255, 255).withOpacity(.8),
                  //   ),
                  child: BlocBuilder<QuizPageBloc, QuizPageState>(
                    builder: (context, state) {
                      //now many cases in the state status check the status and call different function accordingly

                      if (state.status.isReady) {
                        return QuizIntro();
                      } else if (state.status.isStarted) {
                        return QuizInProgress(); //this will load the quiz that user has clicked
                      } else if (state.status.isFinsihed) {
                        return Quizfinsihed(); //call finished method
                      } else {
                        //end the end it will show the circular loading indication
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              //),
            ],
          ) //Quizinprogress(), //this quizinprogress is class contains the quiz start button

          ),
    );
  }
}

//now we have to create an appbar with out preffered size
class QuizPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuizPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 35, 151, 130),
      elevation: 0,
      title: Text(
        context.watch<QuizPageBloc>().quiz.name,
        style: TextStyle(
          color: const Color.fromARGB(
              255, 0, 0, 0), // Set your desired text color here
          fontSize: 20, // Optional: Adjust the font size if needed
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(42); // Define the preferred size
}
