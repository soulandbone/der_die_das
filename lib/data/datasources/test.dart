// abstract class QuizRepository {

// Future<List<Question>> fetchQuestions();

// }

// abstract class QuizDataSource {

// Future<List<Question>> getQuestions();
// }

// class FireBaseQuizDataSource implements QuizDataSource {

//     final FirebaseFirestore firestore;

// FireBaseQuizDataSource(this.firestore );

// Future<List<Question>> getQuestions() async {

//      var questionsRef = firestore.collection('questions');
//     var snapshot = await questionsRef.get();

//     var list =
//         snapshot.docs
//             .map(
//               (doc) => Question(
//                 word: doc['word'],
//                 correctAnswer: doc['correctAnswer'],
//               ),
//             )
//             .toList();

//     return list;
// }

// }


// class QuizRepositoryImpl implements QuizRepository{

//     QuizRepositoryImpl(this.quizDataSource);

//     final QuizDataSource quizDataSource;

// Future<List<Question>> fetchQuestions () {

//     return quizDataSource.getQuestions();
// }



// }