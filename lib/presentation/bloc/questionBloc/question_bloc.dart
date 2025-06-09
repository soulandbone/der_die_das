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

  //List<Question>? savedQuestions10;

  int? timeLeft;
  Timer? timer;

  void startTimer(int initialTime) {
    if (timer != null) {
      releaseTimer();
    }

    timeLeft = initialTime;

    timer = Timer.periodic(Duration(seconds: 1), (_) => subtractTime());
  }

  void subtractTime() {
    final currentState = state as QuizProgress;
    if (timeLeft! > 0) {
      timeLeft = timeLeft! - 1;
      emit(currentState.copyWith(remainingTime: timeLeft));
    } else {
      releaseTimer();
      emit(
        QuizFinished(
          totalQuestions: currentState.questions.length,
          correctQuestions: currentState.totalCorrect,
        ),
      );
    }
  }

  void releaseTimer() {
    timer!.cancel();
  }

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
      final questions =
          await getQuestions.call(); // gets the questions from the server.
      savedQuestions = questions; //caching the questions
      questions.shuffle();

      final questions10 = questions.sublist(0, 10);
      //savedQuestions10 = questions10;
      startTimer(45);
      emit(QuizProgress(questions: savedQuestions!, remainingTime: 45));
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

    if (currentIndex == savedQuestions!.length - 1) {
      emit(
        QuizFinished(
          correctQuestions: totalCorrect,
          totalQuestions: savedQuestions!.length,
        ),
      );
    } else {
      emit(
        QuizProgress(
          questions: questions,
          currentIndex: currentIndex + 1,
          currentScore: score,
          totalCorrect: totalCorrect,
          remainingTime: timeLeft!,
        ),
      );
    }
  }

  FutureOr<void> resetQuiz(ResetQuiz event, Emitter<QuestionState> emit) {
    var questions = savedQuestions;
    if (savedQuestions != null && savedQuestions!.isNotEmpty) {
      questions!.shuffle();
      startTimer(45);
      emit(QuizProgress(questions: questions, remainingTime: 45));
    }
  }
}
