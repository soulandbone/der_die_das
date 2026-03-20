import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/data/datasources/quiz_datasource.dart';
import 'package:der_die_das/domain/entities/question.dart';

class FirebaseQuizDataSource implements QuizDataSource {
  final FirebaseFirestore firestore;

  FirebaseQuizDataSource(this.firestore);

  @override
  Future<List<Question>> getQuestions() async {
    var questionsRef = firestore.collection('questions');
    var snapshot = await questionsRef.get();

    var list =
        snapshot.docs
            .map(
              (doc) => Question(
                word: doc['word'],
                correctAnswer: doc['correctAnswer'],
              ),
            )
            .toList();

    return list;
  }
}
