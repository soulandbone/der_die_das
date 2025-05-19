import 'package:der_die_das/data/datasources/firebase_quiz_data_source.dart';
import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  FirebaseQuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);
  @override
  Future<List<Question>> fetchQuestions() {
    return dataSource.getQuestions();
  }
}
