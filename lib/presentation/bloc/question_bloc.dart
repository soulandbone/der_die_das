import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestions getQuestions;
  QuestionBloc(this.getQuestions) : super(QuestionsLoading()) {
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
      emit(QuestionsLoaded(questions: questions));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }

  FutureOr<void> answerConfirmed(
    AnswerConfirmed event,
    Emitter<QuestionState> emit,
  ) async {
    final questions = await getQuestions.call();
    final currentIndex = (state as QuestionsLoaded).currentIndex;
    var currentScore = (state as QuestionsLoaded).currentScore;
    var nextIndex = currentIndex + 1;

    if (event.isCorrect) {
      currentScore = (state as QuestionsLoaded).currentScore + 100;
    }

    if (nextIndex == questions.length) {
      emit(ReachedEndOfQuestionnaire());
      return;
    }
    emit(
      QuestionsLoaded(
        questions: questions,
        currentIndex: nextIndex,
        currentScore: currentScore,
      ),
    );
  }
}
