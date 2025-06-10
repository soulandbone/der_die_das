import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';
import 'package:der_die_das/firebase_options.dart';
import 'package:der_die_das/injection_container.dart';
import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:der_die_das/presentation/screens/home.dart';
import 'package:der_die_das/presentation/screens/menu.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup(); // initializing dependencies

  final themeBloc = ThemeBloc();

  runApp(BlocProvider.value(value: themeBloc, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;

    final getQuestions = getIt<GetQuestions>();
    final checkAnswer = getIt<CheckAnswer>();
    final updateScore = getIt<UpdateScore>();

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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:
            (currentState as Settings).isDark
                ? ThemeData.dark()
                : ThemeData.light(),
        home: MenuScreen(), //HomeScreen(),
      ),
    );
  }
}
