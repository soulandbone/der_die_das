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

  QuestionBloc(this.getQuestions, this.checkAnswer, this.updateScore)
    : super(QuestionsLoading()) {
    on<LoadQuestions>(loadQuestions);
    on<AnswerConfirmed>(answerConfirmed);
  }

  FutureOr<void> loadQuestions(
    LoadQuestions event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionsLoading());
    try {
      final questions = await getQuestions.call();
      questions.shuffle();
      emit(QuizProgress(questions: questions));
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

    emit(
      QuizProgress(
        questions: questions,
        currentIndex: currentIndex + 1,
        currentScore: score,
        totalCorrect: totalCorrect,
        isFinished: currentIndex == questions.length - 1 ? true : false,
      ),
    );
  }
}
