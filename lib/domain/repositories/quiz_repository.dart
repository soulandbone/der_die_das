import 'package:der_die_das/domain/entities/question.dart';

abstract class QuizRepository {
  Future<List<Question>> fetchQuestions();
}
