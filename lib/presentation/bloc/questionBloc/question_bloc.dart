import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:der_die_das/domain/contracts/ticker.dart';
import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc(
    this.getQuestions,
    this.checkAnswer,
    this.updateScore,
    this.ticker,
  ) : super(QuestionsLoading()) {
    on<LoadQuestions>(loadQuestions);
    on<AnswerConfirmed>(answerConfirmed);
    on<ResetQuiz>(resetQuiz);
    on<StartQuizWithOptions>(startQuizWithOptions);
    on<ReturnToMainMenu>(returnToMainMenu);
    on<TimerTick>(timerTick);
  }

  final GetQuestions getQuestions;
  final CheckAnswer checkAnswer;
  final UpdateScore updateScore;
  final Ticker ticker;

  StreamSubscription? _tickerSub;

  List<Question>? savedQuestions;
  List<Question>? questionsToUse;

  Map<String, dynamic>? initialValues;

  void startTicker(int seconds) {
    if (seconds <= 0) return;
    stopTicker();
    _tickerSub = ticker.tick(seconds).listen((remaining) {
      add(TimerTick(remaining));
    });
  }

  void stopTicker() {
    _tickerSub?.cancel();
    _tickerSub = null;
  }

  @override
  Future close() {
    stopTicker(); // cancel subscription
    return super.close();
  }

  FutureOr<void> loadQuestions(
    LoadQuestions event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionsLoading());
    try {
      final questions =
          await getQuestions(); // gets the questions from the server.
      savedQuestions = questions; //caching the questions
      questions.shuffle();

      emit(QuestionsLoaded(questions: savedQuestions!));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  FutureOr<void> timerTick(TimerTick event, Emitter<QuestionState> emit) async {
    if (state is! QuizInProgress) return;
    final currentState = state as QuizInProgress;
    final remainingTime = event.remaining;

    if (remainingTime > 0) {
      emit(currentState.copyWith(remainingTime: remainingTime));
    } else {
      stopTicker(); //time reached zero, quiz has finished
      emit(
        QuizFinished(
          totalQuestions: ((currentState.currentIndex ?? 0)),
          correctQuestions: currentState.totalCorrect ?? 0,
          quizType: currentState.quizType!,
        ),
      );
    }
  }

  FutureOr<void> answerConfirmed(
    AnswerConfirmed event,
    Emitter<QuestionState> emit,
  ) async {
    if (state is! QuizInProgress) return;
    final currentState = (state as QuizInProgress);
    final questions = currentState.questions;
    var currentIndex = currentState.currentIndex;
    var currentScore = currentState.currentScore;
    var totalCorrect = currentState.totalCorrect;
    var remainingTime = currentState.remainingTime;
    var correctAnswer = checkAnswer(
      answer: event.answer,
      correctAnswer: questions![currentIndex!].correctAnswer,
    );
    var score = updateScore(
      isCorrect: correctAnswer,
      currentScore: currentScore!,
    );
    if (totalCorrect != null) {
      totalCorrect = correctAnswer ? totalCorrect + 1 : totalCorrect;
    }

    if (currentIndex == questionsToUse!.length - 1) {
      emit(
        QuizFinished(
          quizType: currentState.quizType!,
          correctQuestions: totalCorrect!,
          totalQuestions: questionsToUse!.length,
        ),
      );
    } else {
      emit(
        currentState.copyWith(
          currentIndex: currentIndex + 1,
          totalCorrect: totalCorrect,
          currentScore: score,
          remainingTime: remainingTime,
        ),
      );
    }
  }

  FutureOr<void> resetQuiz(ResetQuiz event, Emitter<QuestionState> emit) {
    emit(
      QuizInProgress(
        numberOfQuestions: initialValues!['numberOfQuestions'],
        quizType: initialValues!['quizType'],
        startingTime: initialValues!['time'],
        currentScore: 0,
        currentIndex: 0,
        questions: questionsToUse,
        totalCorrect: 0,
        remainingTime: initialValues!['time'],
      ),
    );
    if (initialValues!['time'] != null) {
      startTicker(initialValues!['time']);
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
    } else {
      totalTime = null;
    }

    emit(
      QuizInProgress(
        questions: questionsToUse,
        currentIndex: 0,
        currentScore: 0,
        totalCorrect: 0,
        remainingTime: totalTime,
        startingTime: totalTime,
        quizType: event.quizType,
        numberOfQuestions: numberOfquestions,
      ),
    );
    initialValues = {
      'quizType': event.quizType,
      'numberOfQuestions': event.numberOfQuestions,
      'time': event.time,
    };
    if (totalTime != null) {
      startTicker(totalTime);
    }
  }

  FutureOr<void> returnToMainMenu(
    ReturnToMainMenu event,
    Emitter<QuestionState> emit,
  ) {
    emit(QuestionsLoaded(questions: savedQuestions!));
  }
}
