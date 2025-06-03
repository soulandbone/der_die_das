import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/data/datasources/firebase_quiz_data_source.dart';
import 'package:der_die_das/data/repositories/quiz_repository_impl.dart';
import 'package:der_die_das/domain/repositories/quiz_repository.dart';

import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => FirebaseQuizDataSource(getIt()));
  getIt.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(getIt<FirebaseQuizDataSource>()),
  );
  getIt.registerLazySingleton(() => GetQuestions(repository: getIt()));
  getIt.registerLazySingleton(() => CheckAnswer());
  getIt.registerLazySingleton(() => UpdateScore());
}
