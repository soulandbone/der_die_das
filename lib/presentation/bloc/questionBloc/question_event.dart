part of 'question_bloc.dart';

abstract class QuestionEvent {}

class LoadQuestions extends QuestionEvent {}

class AnswerConfirmed extends QuestionEvent {
  AnswerConfirmed({required this.answer});
  final String answer;
}

class ResetQuiz extends QuestionEvent {
  ResetQuiz();
}

class StartQuiz extends QuestionEvent {}

class StartQuizWithOptions extends QuestionEvent {
  StartQuizWithOptions({
    this.numberOfQuestions,
    this.time,
    required this.quizType,
  });
  final int? numberOfQuestions;
  final int? time;
  final TypeOfQuiz quizType;
}
