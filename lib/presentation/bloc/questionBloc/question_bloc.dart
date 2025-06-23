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

  Map<String, dynamic>? initialValues;

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
          quizType: currentState.quizType!,
          totalQuestions: currentState.currentIndex!,
          correctQuestions: currentState.totalCorrect!,
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
          quizType: quizProgressState.quizType!,
          correctQuestions: totalCorrect!,
          totalQuestions: questionsToUse!.length,
        ),
      );
    } else {
      emit(
        quizProgressState.copyWith(
          currentIndex: currentIndex + 1,
          totalCorrect: totalCorrect,
          currentScore: score,
          remainingTime: timeLeft,
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
      startTimer(initialValues!['time']);
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
      startTimer(totalTime);
    }
  }
}
