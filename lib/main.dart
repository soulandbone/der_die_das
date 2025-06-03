import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:der_die_das/data/datasources/firebase_quiz_data_source.dart';
import 'package:der_die_das/data/repositories/quiz_repository_impl.dart';
import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';
import 'package:der_die_das/firebase_options.dart';
import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:der_die_das/presentation/screens/home.dart';
import 'package:der_die_das/theming/app_theming.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final themeBloc = ThemeBloc();

  runApp(BlocProvider.value(value: themeBloc, child: MyApp()));
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
    var checkAnswer = CheckAnswer();
    var updateScore = UpdateScore();

    final currentState = context.watch<ThemeBloc>().state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  QuestionBloc(getQuestions, checkAnswer, updateScore)
                    ..add(LoadQuestions()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:
            (currentState as ActiveTheme).mode == ThemeModeType.dark
                ? ThemeData.dark()
                : ThemeData.light(),
        home: HomeScreen(),
      ),
    );
  }
}
