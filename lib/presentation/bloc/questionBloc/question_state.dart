part of 'question_bloc.dart';

enum TypeOfQuiz { timed, untimed }

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
  QuizFinished({
    required this.totalQuestions,
    required this.correctQuestions,
    required this.quizType,
  });
  final int totalQuestions;
  final int correctQuestions;
  final TypeOfQuiz quizType;
}

class QuizInProgress extends QuestionState {
  QuizInProgress({
    required this.quizType,
    this.numberOfQuestions,
    this.currentScore = 0,
    this.currentIndex = 0,
    this.totalCorrect = 0,
    this.remainingTime,
    required this.questions,
    this.startingTime,
  });

  final List<Question> questions;
  final int currentScore;
  final int currentIndex;
  final int totalCorrect;
  final int? remainingTime;
  final int? startingTime;
  final int? numberOfQuestions;
  final TypeOfQuiz quizType;

  QuizInProgress copyWith({
    List<Question>? questions,
    int? currentScore,
    int? currentIndex,
    int? totalCorrect,
    int? remainingTime,
    int? numberOfQuestions,
    int? startingTime,
    TypeOfQuiz? quizType,
  }) {
    return QuizInProgress(
      questions: questions ?? this.questions,
      currentScore: currentScore ?? this.currentScore,
      currentIndex: currentIndex ?? this.currentIndex,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      remainingTime: remainingTime ?? this.remainingTime,
      quizType: quizType ?? this.quizType,
      numberOfQuestions: numberOfQuestions ?? this.numberOfQuestions,
      startingTime: startingTime ?? this.startingTime,
    );
  }
}
