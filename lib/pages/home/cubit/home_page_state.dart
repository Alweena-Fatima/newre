part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageLoaded extends HomePageState {
  final List<Quiz> quizzes;
  final String category;

  HomePageLoaded({required this.category,required this.quizzes});
  @override
  List<Object> get props => [category, quizzes];
  
}
final class HomePageLoading extends HomePageState {}

