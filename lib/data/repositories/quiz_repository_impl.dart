import 'package:der_die_das/data/datasources/quiz_datasource.dart';
import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);
  @override
  Future<List<Question>> fetchQuestions() {
    return dataSource.getQuestions();
  }
}
