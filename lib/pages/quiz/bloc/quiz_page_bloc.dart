//bloc seprates the buisness logic and logic b stands for buisness and loc for logic
////from the presentation layers which are the pages is the visuallookout
/////creating bloc in quiz folder automatically loaded the all 3 bloc_bloc,event,state file
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/models/quiz_model.dart';

part 'quiz_page_event.dart';
part 'quiz_page_state.dart';

class QuizPageBloc extends Bloc<QuizPageEvent, QuizPageState> {
  QuizPageBloc({required Quiz quiz})
      : _quiz = quiz,
        super(QuizPageState()) {
    //make a list of all the events and call

    //load page event and what we want to do on its call
    on<LoadPage>(
        _onLoadPage); //we can the on load class here but it will be messy
    on<StartQuiz>(_onStartQuiz);
    on<AnswerQuestion>(_AnswerQuestion);
    on<NextQuestion>(_NextQuestion);
  }
  //everywhere in the bloack need access to quizrepo /the curr quiz
  //final QuizRepository _quizRepository; //this underscore makes it private we need to pass in into the block
  final Quiz _quiz;

  //what ever id we've set in our quiz block state as we do here is going to be returned
  Quiz get quiz => _quiz;
  //Quiz get quiz => _quizRepository.getQuizById(state.quizId);

  //now specify what you want to do on the load of page
  //we want to change the state
  FutureOr<void> _onLoadPage(LoadPage event, Emitter<QuizPageState> emit) {
    if (_quiz.random) {
      _quiz.questions.shuffle();
    }
    //create new state and then emit it
    //when we emit anything thats watching that state for c
    //hanges will update any widgets we have got which is watching thsi state will change
    emit(
      state.copyWith(
        status: QuizStatus.ready,
        quizId: event.quizId,
      ),
    );
  }

  FutureOr<void> _onStartQuiz(StartQuiz event, Emitter<QuizPageState> emit) {
    //emit the state
    emit(
      state.copyWith(
        status: QuizStatus.started,
        questionNumber: 0, //when the quiz called it should always start from 0
        answerIdx: -99,
        score: 0,
      ),
    );
  }

//modify the answerquestion function
  FutureOr<void> _AnswerQuestion(
      AnswerQuestion event, Emitter<QuizPageState> emit) {
    //check if question is answered or not if yes

    int score = state.score;
    if (state.answerStatus.isUnanswered) {
      //if the answer is correct then add 10 to the score
      score += event.isCorrect ? 10 : -1;
    }
    //emit the state
    emit(
      state.copyWith(
        answerStatus:
            event.isCorrect ? AnswerStatus.correct : AnswerStatus.wrong,
        answerIdx: event.answerIdx,
        score: score,
      ),
    );
  }

  FutureOr<void> _NextQuestion(
      NextQuestion event, Emitter<QuizPageState> emit) {
    int nextQuestion = state.questionNumber + 1; //currquestion index +1
    //if next question is not the last question then switch to the next question
    if (nextQuestion < quiz.questions.length) {
      emit(
        state.copyWith(
            questionNumber: nextQuestion,
            answerIdx: -99,
            answerStatus: AnswerStatus.unanswered),
      );
    } else {
      //if current questionis the last then emit the quiz finished class
      emit(
        state.copyWith(
          status: QuizStatus.finished,
        ),
      );
    }
  }
}
