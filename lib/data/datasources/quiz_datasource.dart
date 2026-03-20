import 'package:der_die_das/domain/entities/question.dart';

abstract class QuizDataSource {
  Future<List<Question>> getQuestions();
}
