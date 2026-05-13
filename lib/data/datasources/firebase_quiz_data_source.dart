import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/data/datasources/quiz_datasource.dart';
import 'package:der_die_das/data/models/question_model.dart';

class FirebaseQuizDataSource implements QuizDataSource {
  final FirebaseFirestore firestore;

  FirebaseQuizDataSource(this.firestore);

  @override
  Future<List<QuestionModel>> getQuestions() async {
    var questionsRef = firestore.collection('questions');
    var snapshot = await questionsRef.get();

    return snapshot.docs.map((e) => QuestionModel.fromMap(e.data())).toList();
  }
}
