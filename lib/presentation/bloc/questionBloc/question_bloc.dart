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
    on<StartUntimedQuiz>(startUntimedQuiz);
    on<StartTimedQuiz>(startTimedQuiz);
    on<ReturnToMainMenu>(returnToMainMenu);
    on<TimerTick>(timerTick);
  }

  final GetQuestions getQuestions;
  final CheckAnswer checkAnswer;
  final UpdateScore updateScore;
  final Ticker ticker;

  StreamSubscription<int>? _tickerSub;

  List<Question> savedQuestions = []; //for cacheing the questions

  Map<String, dynamic>? initialValues;

  void startTicker(int startingTime) {
    if (startingTime <= 0) return;
    stopTicker();
    _tickerSub = ticker.tick(startingTime).listen((remaining) {
      add(TimerTick(remaining));
    });
  }

  void stopTicker() {
    _tickerSub?.cancel();
    _tickerSub = null;
  }

  @override
  Future<void> close() {
    stopTicker(); // cancel subscription
    return super.close();
  }

  FutureOr<void> loadQuestions(
    LoadQuestions event,
    Emitter<QuestionState> emit,
  ) async {
    //QuestionsLoading state was here, initially as emit(QuestionsLoading), but was left out in a second iteration of the code, because that is already the
    // initial state for the Bloc
    //And the Bloc upon creation already dispatches immediately this event : LoadQuestions(see main.dart)

    try {
      final questions =
          await getQuestions(); // gets the questions from the server.
      savedQuestions = questions; //caching the questions
      savedQuestions.shuffle();

      emit(QuestionsLoaded(questions: savedQuestions));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  void timerTick(TimerTick event, Emitter<QuestionState> emit) {
    if (state is! QuizInProgress) return;
    final currentState = state as QuizInProgress;
    final remainingTime = event.remaining;

    if (currentState.remainingTime == remainingTime) return;

    if (remainingTime > 0) {
      emit(currentState.copyWith(remainingTime: remainingTime));
    } else {
      stopTicker(); //time reached zero, quiz has finished
      emit(
        QuizFinished(
          totalQuestions: ((currentState.currentIndex)),
          correctQuestions: currentState.totalCorrect,
          quizType: currentState.quizType,
        ),
      );
    }
  }

  void answerConfirmed(AnswerConfirmed event, Emitter<QuestionState> emit) {
    if (state is! QuizInProgress) return;
    final currentState = (state as QuizInProgress);
    final questions = currentState.questions;
    var currentIndex = currentState.currentIndex;
    var currentScore = currentState.currentScore;
    var totalCorrect = currentState.totalCorrect;
    var remainingTime = currentState.remainingTime;
    var correctAnswer = checkAnswer(
      question: questions[currentIndex],
      answer: event.answer,
    );
    var score = updateScore(
      isCorrect: correctAnswer,
      currentScore: currentScore,
    );

    totalCorrect = correctAnswer ? totalCorrect + 1 : totalCorrect;

    if (currentIndex == questions.length - 1) {
      stopTicker();
      emit(
        QuizFinished(
          quizType: currentState.quizType,
          correctQuestions: totalCorrect,
          totalQuestions: questions.length,
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

  void resetQuiz(ResetQuiz event, Emitter<QuestionState> emit) {
    emit(
      QuizInProgress(
        numberOfQuestions: initialValues!['numberOfQuestions'],
        quizType: initialValues!['quizType'],
        startingTime: initialValues!['time'],
        currentScore: 0,
        currentIndex: 0,
        questions: initialValues!['questions'],
        totalCorrect: 0,
        remainingTime: initialValues!['time'],
      ),
    );
    if (initialValues!['time'] != 0) {
      startTicker(initialValues!['time']);
    }
  }

  void startTimedQuiz(StartTimedQuiz event, Emitter<QuestionState> emit) {
    emit(
      QuizInProgress(
        questions: savedQuestions,
        currentScore: 0,
        currentIndex: 0,
        totalCorrect: 0,
        remainingTime: event.time,
        startingTime: event.time,
        numberOfQuestions: 0,
        quizType: TypeOfQuiz.timed,
      ),
    );

    initialValues = {
      'quizType': TypeOfQuiz.timed,
      'numberOfQuestions': 0,
      'time': event.time,
      'questions': savedQuestions,
    };

    startTicker(event.time);
  }

  void startUntimedQuiz(StartUntimedQuiz event, Emitter<QuestionState> emit) {
    var numberOfQuestions = event.numberOfQuestions;

    savedQuestions.shuffle();

    if (numberOfQuestions > savedQuestions.length) {
      numberOfQuestions = savedQuestions.length;
    }

    final questionsToUse = savedQuestions.sublist(0, numberOfQuestions);

    emit(
      QuizInProgress(
        questions: questionsToUse,
        currentScore: 0,
        currentIndex: 0,
        totalCorrect: 0,
        remainingTime: 0,
        startingTime: 0,
        numberOfQuestions: numberOfQuestions,
        quizType: TypeOfQuiz.untimed,
      ),
    );

    initialValues = {
      'quizType': TypeOfQuiz.untimed,
      'numberOfQuestions': event.numberOfQuestions,
      'time': 0,
      'questions': questionsToUse,
    };
  }

  void returnToMainMenu(ReturnToMainMenu _, Emitter<QuestionState> emit) {
    stopTicker();
    emit(QuestionsLoaded(questions: savedQuestions));
  }
}
