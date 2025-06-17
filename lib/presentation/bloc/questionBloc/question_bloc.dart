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
  List<Question>? questionsToUse;

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
    final currentState = state as QuizInProgress;
    if (timeLeft! > 0) {
      timeLeft = timeLeft! - 1;
      emit(currentState.copyWith(remainingTime: timeLeft));
    } else {
      releaseTimer();
      emit(
        QuizFinished(
          quizType: currentState.quizType,
          totalQuestions: questionsToUse!.length,
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
    on<StartQuiz>(startQuiz);
    on<StartQuizWithOptions>(startQuizWithOptions);
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

      emit(QuestionsLoaded(questions: savedQuestions!));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  FutureOr<void> answerConfirmed(
    AnswerConfirmed event,
    Emitter<QuestionState> emit,
  ) async {
    final quizProgressState = (state as QuizInProgress);
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

    if (currentIndex == questionsToUse!.length - 1) {
      emit(
        QuizFinished(
          quizType: quizProgressState.quizType,
          correctQuestions: totalCorrect,
          totalQuestions: questionsToUse!.length,
        ),
      );
    } else {
      emit(
        QuizInProgress(
          quizType: quizProgressState.quizType,
          questions: questions,
        ).copyWith(
          currentIndex: currentIndex + 1,
          totalCorrect: totalCorrect,
          currentScore: score,
          remainingTime: timeLeft,
          startingTime: quizProgressState.startingTime,
        ),
      );
    }
  }

  FutureOr<void> resetQuiz(ResetQuiz event, Emitter<QuestionState> emit) {
    var questions = savedQuestions;
    if (savedQuestions != null && savedQuestions!.isNotEmpty) {
      questions!.shuffle();
      startTimer(45);
      emit(
        QuizInProgress(
          quizType: TypeOfQuiz.timed,
          questions: questions,
          remainingTime: 45,
        ),
      );
    }
  }

  FutureOr<void> startQuiz(StartQuiz event, Emitter<QuestionState> emit) {
    var questions = savedQuestions;
    if (savedQuestions != null && savedQuestions!.isNotEmpty) {
      questions!.shuffle();
      startTimer(45);
      emit(
        QuizInProgress(
          quizType: TypeOfQuiz.timed,
          questions: questions,
          remainingTime: 45,
        ),
      );
    }
  }

  FutureOr<void> startQuizWithOptions(
    StartQuizWithOptions event,
    Emitter<QuestionState> emit,
  ) {
    var numberOfquestions = event.numberOfQuestions;

    if (numberOfquestions != null) {
      questionsToUse = savedQuestions!.sublist(0, numberOfquestions);
    } else {
      questionsToUse = savedQuestions!;
    }

    int? totalTime = 0;
    if (event.time != null) {
      totalTime = event.time!;
      //  print('Total time is $totalTime');
    } else {
      totalTime = null;
    }

    emit(
      QuizInProgress(
        quizType: event.quizType,
        questions: questionsToUse!,
        remainingTime: totalTime,
        startingTime: totalTime,
      ),
    );
    if (totalTime != null) {
      startTimer(totalTime);
    }
  }
}
