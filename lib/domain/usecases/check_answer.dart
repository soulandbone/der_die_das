import 'package:der_die_das/domain/entities/question.dart';

class CheckAnswer {
  bool call({required Question question, required String answer}) {
    return question.isCorrect(answer);
  }
}
