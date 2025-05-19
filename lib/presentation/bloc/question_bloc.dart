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
  }

  FutureOr<void> loadQuestions(
    LoadQuestions event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionsLoading());
    try {
      final questions = await getQuestions.call();
      emit(QuestionsLoaded(questions));
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }
}
