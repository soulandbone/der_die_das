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

class QuizFinished extends QuestionState {
  QuizFinished({required this.totalQuestions, required this.correctQuestions});
  final int totalQuestions;
  final int correctQuestions;
}

class QuizProgress extends QuestionState {
  QuizProgress({
    this.currentScore = 0,
    this.currentIndex = 0,
    this.totalCorrect = 0,
    this.remainingTime = 0,
    required this.questions,
  });

  final List<Question> questions;
  final int currentScore;
  final int currentIndex;
  final int totalCorrect;
  final int remainingTime;

  QuizProgress copyWith({
    List<Question>? questions,
    int? currentScore,
    int? currentIndex,
    int? totalCorrect,
    int? remainingTime,
  }) {
    return QuizProgress(
      questions: questions ?? this.questions,
      currentScore: currentScore ?? this.currentScore,
      currentIndex: currentIndex ?? this.currentIndex,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}
