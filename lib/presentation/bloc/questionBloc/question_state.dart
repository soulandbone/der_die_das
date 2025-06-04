part of 'question_bloc.dart';

abstract class QuestionState {}

final class QuestionInitial extends QuestionState {}

class QuestionsLoading extends QuestionState {}

class QuestionsLoaded extends QuestionState {
  QuestionsLoaded({required this.questions});

  final List<Question> questions;
}

class QuestionsError extends QuestionState {
  QuestionsError(this.message);
  final String message;
}

class QuizReset extends QuestionState {}

class QuizProgress extends QuestionState {
  QuizProgress({
    this.currentScore = 0,
    this.currentIndex = 0,
    this.totalCorrect = 0,
    required this.questions,
    this.isFinished = false,
  });

  final List<Question> questions;
  final int currentScore;
  final int currentIndex;
  final int totalCorrect;
  final bool isFinished;

  QuizProgress copyWith({
    List<Question>? questions,
    int? currentScore,
    int? currentIndex,
    int? totalCorrect,
    bool? isFinished,
  }) {
    return QuizProgress(
      questions: questions ?? this.questions,
      currentScore: currentScore ?? this.currentScore,
      currentIndex: currentIndex ?? this.currentIndex,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
