part of 'question_bloc.dart';

abstract class QuestionEvent {}

class LoadQuestions extends QuestionEvent {}

class AnswerConfirmed extends QuestionEvent {
  AnswerConfirmed({required this.answer});
  final String answer;
}

class ResetQuiz extends QuestionEvent {}

class TimerTick extends QuestionEvent {
  // each time one of these events are thrown, we need to know how much time left there is

  TimerTick(this.remaining);
  final int remaining;
}

class ReturnToMainMenu extends QuestionEvent {}

class StartQuiz extends QuestionEvent {}

class StartTimedQuiz extends QuestionEvent {
  StartTimedQuiz({required this.time});

  final int time;
}

class StartUntimedQuiz extends QuestionEvent {
  StartUntimedQuiz({required this.numberOfQuestions});

  final int numberOfQuestions;
}
