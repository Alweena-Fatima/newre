part of 'quiz_page_bloc.dart';
//thinks about the all the event that are likely going to happen it is an action or something happening by default
//eg such as page is beginning to load or action that a user has taken maybe to click button or slide the slider

sealed class QuizPageEvent extends Equatable {
  const QuizPageEvent();

  @override
  List<Object> get props => [];
}

//this class will load the curr quiz page
//when will call this event or load the page we gonna have to pass the quizid
class LoadPage extends QuizPageEvent {
  final String quizId;
  const LoadPage({required this.quizId});
  @override
  List<Object> get props => [quizId];
}

//this class is start page with start button \
class StartQuiz extends QuizPageEvent {}

//this class will show answer question event when user click the answer will will not automatically load the next question it will show whether the answer is worng or correct
class AnswerQuestion extends QuizPageEvent {
  final bool isCorrect;
  final int answerIdx;
  const AnswerQuestion({required this.isCorrect, required this.answerIdx});
  @override
  List<Object> get props => [isCorrect, answerIdx];
}

//this nextquestion event load the nextq question
class NextQuestion extends QuizPageEvent {
  
}
