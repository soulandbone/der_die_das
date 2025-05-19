import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/data/datasources/firebase_quiz_data_source.dart';
import 'package:der_die_das/data/repositories/quiz_repository_impl.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/firebase_options.dart';
import 'package:der_die_das/presentation/bloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var firestore = FirebaseFirestore.instance;
    var dataSource = FirebaseQuizDataSource(firestore);
    var repository = QuizRepositoryImpl(dataSource);
    var getQuestions = GetQuestions(repository: repository);
    return BlocProvider(
      create: (context) {
        return (QuestionBloc(getQuestions)..add(
          LoadQuestions(),
        )); // It's the same as QuestionBloc questionBloc = QuestionBloc(getQuestions); questionBloc.add(LoadQuestions())
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
