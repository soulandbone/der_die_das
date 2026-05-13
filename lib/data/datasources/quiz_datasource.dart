import 'package:der_die_das/data/models/question_model.dart';

abstract class QuizDataSource {
  Future<List<QuestionModel>> getQuestions();
}
