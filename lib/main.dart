import 'package:der_die_das/domain/contracts/ticker.dart';
import 'package:der_die_das/domain/usecases/check_answer.dart';
import 'package:der_die_das/domain/usecases/get_questions.dart';
import 'package:der_die_das/domain/usecases/update_score.dart';
import 'package:der_die_das/firebase_options.dart';
import 'package:der_die_das/injection_container.dart';
import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';

import 'package:der_die_das/presentation/screens/menu.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup(); // initializing dependencies

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
          create:
              (context) => QuestionBloc(
                getIt<GetQuestions>(),
                getIt<CheckAnswer>(),
                getIt<UpdateScore>(),
                getIt<Ticker>(),
              )..add(LoadQuestions()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<ThemeBloc>().state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:
          (currentState).isDark
              ? FlexThemeData.dark(scheme: FlexScheme.flutterDash)
              : FlexThemeData.light(scheme: FlexScheme.flutterDash),
      //: FlexThemeData.light(),
      home: MenuScreen(), //HomeScreen(),
    );
  }
}
