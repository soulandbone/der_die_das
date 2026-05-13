import 'package:der_die_das/domain/entities/question.dart';
import 'package:der_die_das/domain/repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions({required this.repository});

  Future<List<Question>> call() {
    return repository.fetchQuestions();
  }
}
