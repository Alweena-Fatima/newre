import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_app/models/quiz_model.dart';
import 'package:first_app/repositories/quiz_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final QuizRepository _quizRepository;
  HomePageCubit({required QuizRepository qr})
      : _quizRepository = qr,
        super(HomePageLoading()) {
    _loadQuizList(update: true);
  }
  _loadQuizList({String category = 'gen', bool update = false}) async {
    if (update) {
      await _quizRepository
          .checkForUpdate(); //when load quiz is call it is going to load sort and make quiz in category
    }

    //here we will check the category and display according to the passes repo
    List<Quiz> quizzes = _quizRepository
        .loadQuizList()
        .where((quiz) => quiz.category == category)
        .toList();
    quizzes.sort((a, b) => a.sortOrder - b.sortOrder); //IMPPPPPPP
    emit(HomePageLoaded(quizzes: quizzes, category: category));
  }

  //function allow to change the category after click on elevated button
  chageCategory(String code) {
    emit(HomePageLoading());
    _loadQuizList(category: code);
  }
}
