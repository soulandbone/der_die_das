import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestions getQuestions;
  final CheckAnswer checkAnswer;
  final UpdateScore updateScore;

  List<Question>? savedQuestions;

  List<Question>?
  savedQuestions10; //so we dont have to fetch the questions from the server later

  QuestionBloc(this.getQuestions, this.checkAnswer, this.updateScore)
    : super(QuestionsLoading()) {
    on<LoadQuestions>(loadQuestions);
    on<AnswerConfirmed>(answerConfirmed);
    on<ResetQuiz>(resetQuiz);
  }

  FutureOr<void> loadQuestions(
    LoadQuestions event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionsLoading());
    try {
      final questions = await getQuestions.call();
      savedQuestions = questions; //caching the questions
      questions.shuffle();
      final questions10 = questions.sublist(0, 10);
      savedQuestions10 = questions10;
      emit(QuizProgress(questions: questions10));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  FutureOr<void> answerConfirmed(
    AnswerConfirmed event,
    Emitter<QuestionState> emit,
  ) async {
    final quizProgressState = (state as QuizProgress);
    final questions = quizProgressState.questions;
    var currentIndex = quizProgressState.currentIndex;
    var currentScore = quizProgressState.currentScore;
    var totalCorrect = quizProgressState.totalCorrect;
    var correctAnswer = checkAnswer(
      answer: event.answer,
      correctAnswer: questions[currentIndex].correctAnswer,
    );
    var score = updateScore(
      isCorrect: correctAnswer,
      currentScore: currentScore,
    );
    totalCorrect = correctAnswer ? totalCorrect + 1 : totalCorrect;

    if (currentIndex == 9) {
      emit(
        QuizFinished(
          correctQuestions: totalCorrect,
          totalQuestions: savedQuestions10!.length,
        ),
      );
    } else {
      emit(
        QuizProgress(
          questions: questions,
          currentIndex: currentIndex + 1,
          currentScore: score,
          totalCorrect: totalCorrect,
        ),
      );
    }
  }

  FutureOr<void> resetQuiz(ResetQuiz event, Emitter<QuestionState> emit) {
    var questions = savedQuestions;
    if (savedQuestions != null && savedQuestions!.isNotEmpty) {
      questions!.shuffle();
      emit(QuizProgress(questions: questions));
    }
  }
}
