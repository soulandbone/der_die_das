import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/domain/entities/question.dart';

class FirebaseQuizDataSource {
  final FirebaseFirestore firestore;

  FirebaseQuizDataSource(this.firestore);

  Future<List<Question>> getQuestions() async {
    var questionsRef = FirebaseFirestore.instance.collection('questions');
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
