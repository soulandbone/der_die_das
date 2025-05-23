part of 'question_bloc.dart';

abstract class QuestionEvent {}

class LoadQuestions extends QuestionEvent {}

class AnswerConfirmed extends QuestionEvent {
  AnswerConfirmed({required this.isCorrect});
  final bool isCorrect;
}
