// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'quiz_page_bloc.dart';

//bloc work by chaeking the state objects and it compares them to see wheather the status change and to decide whether the widgets need to get updated or redrawn
//actual status of the page
enum QuizStatus {
  initial,
  ready, //when quiz is loaded from data base
  started,
  finished,
  answered,
}

//create extensionto make code look little be simpler
extension QuizStatusX on QuizStatus {
  bool get isInitial => this == QuizStatus.initial;
  bool get isReady => this == QuizStatus.ready;
  bool get isStarted => this == QuizStatus.started;
  bool get isFinsihed => this == QuizStatus.finished;
}

//how we are going to answer the question
//information we need if selected is correct or wrong
enum AnswerStatus {
  correct,
  unanswered,
  wrong,
}

//create extension to make code look little be simpler
extension AnswerStatusX on AnswerStatus {
  bool get isCorrect => this == AnswerStatus.correct;
  bool get isUnanswered => this == AnswerStatus.unanswered;
  bool get isWrong => this == AnswerStatus.wrong;
}

class QuizPageState extends Equatable {
//one property we need a track of  is quiz status
  final QuizStatus status; // status of the quiz
  final String quizId; //keep track of id
  final int questionNumber; //keep track of current question number
  //constructor
  final AnswerStatus answerStatus; //keep track of answer status
  final int answerIdx;
  final int score;//this will calculate the score of quiz 
  const QuizPageState({
    //remove req and set initial value
    this.status = QuizStatus.initial,
    this.quizId = '',
    this.questionNumber = 0, //first question
    this.answerStatus = AnswerStatus.unanswered,
    this.answerIdx = -99,
    this.score=0,
  });
  //final String name;
  @override
  // List<Object> get props => [name];//now it tells that name is the one of the things that need to get compared to see whether this object  matcehs the another object of the same type
  List<Object> get props => [
        status,
        quizId,
        questionNumber,
        answerStatus,
        answerIdx,
        score,
      ]; //keep track of status questionnumber ,quizid

  QuizPageState copyWith({
    QuizStatus? status,
    String? quizId,
    int? questionNumber,
    AnswerStatus? answerStatus,
    int? answerIdx,
    int? score,
  }) {
    return QuizPageState(
      status: status ?? this.status,
      quizId: quizId ?? this.quizId,
      questionNumber: questionNumber ?? this.questionNumber,
      answerStatus: answerStatus ?? this.answerStatus,
      answerIdx: answerIdx ?? this.answerIdx,
      score: score ?? this.score,
    );
  }
}
