part of 'question_bloc.dart';

abstract class QuestionState {}

final class QuestionInitial extends QuestionState {}

class QuestionsLoading extends QuestionState {}

class QuestionsLoaded extends QuestionState {
  QuestionsLoaded({
    required this.questions,
    this.currentIndex = 0,
    this.currentScore = 0,
  });

  final List<Question> questions;
  final int currentIndex;
  final int currentScore;
}

class QuestionsError extends QuestionState {
  QuestionsError(this.message);
  final String message;
}

class NextQuestionLoaded extends QuestionState {
  NextQuestionLoaded(this.question);
  final Question question;
}

class ReachedEndOfQuestionnaire extends QuestionState {
  ReachedEndOfQuestionnaire();
}
