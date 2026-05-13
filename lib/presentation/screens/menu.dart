import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/quiz.dart';
import 'package:der_die_das/presentation/widgets/drawer/main_drawer.dart';
import 'package:der_die_das/presentation/widgets/mainMenu/CustomSlider/custom_slider.dart';
import 'package:der_die_das/presentation/widgets/mainMenu/main_menu_toggle.dart';
import 'package:der_die_das/presentation/widgets/welcome_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

enum TimedOption {
  s30(30),
  s60(60),
  s120(120),
  customSeconds(null);

  const TimedOption(this.defaultSeconds);
  final int? defaultSeconds;

  int seconds(int customValue) => defaultSeconds ?? customValue;
}

enum UntimedOption {
  q10(10),
  q25(25),
  q50(50),
  customQuestions(null);

  const UntimedOption(this.defaultQuestions);
  final int? defaultQuestions;

  int questions(int customValue) => defaultQuestions ?? customValue;
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isTimed = true;
  TimedOption timedSelection = TimedOption.s30;
  UntimedOption untimedSelection = UntimedOption.q10;
  int customSelectedValue = 20;

  void _startQuiz() {
    final quizBloc = context.read<QuestionBloc>();

    if (isTimed) {
      quizBloc.add(
        StartTimedQuiz(time: timedSelection.seconds(customSelectedValue)),
      );
    } else {
      quizBloc.add(
        StartUntimedQuiz(
          numberOfQuestions: untimedSelection.questions(customSelectedValue),
        ),
      );
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => QuizScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Der,Die,Das',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryFixed),
        ),
        //backgroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      drawer: const MainDrawer(),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionsLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  const WelcomeBanner(),
                  const Gap(40),
                  MainMenuToggle(
                    labels: ['Timed', 'Untimed'],
                    function: (index) {
                      setState(() {
                        isTimed =
                            index ==
                            0; //resets the values for timedSelection and untimedSelection each time that it is changed
                        timedSelection = TimedOption.s30;
                        untimedSelection = UntimedOption.q10;
                        //print('Quiz isTimed is set to $isTimed');
                      });
                    },
                  ),
                  const Gap(15),
                  isTimed
                      ? MainMenuToggle(
                        key: const ValueKey('timed'),
                        labels: ['30 secs', '60 secs', '120 secs', 'Custom'],
                        function: (index) {
                          setState(() {
                            timedSelection = TimedOption.values[index];
                          });
                        },
                      )
                      : MainMenuToggle(
                        key: const ValueKey('untimed'),
                        labels: ['10 Q#s', '25 Q#s', '50 Q#s', 'Custom'],
                        function: (int index) {
                          setState(() {
                            untimedSelection = UntimedOption.values[index];
                          });
                        },
                      ),
                  const Gap(15),
                  (timedSelection == TimedOption.customSeconds ||
                          untimedSelection == UntimedOption.customQuestions)
                      ? CustomSlider(
                        isTimed: isTimed,
                        sliderValue: customSelectedValue.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            customSelectedValue = value.toInt();
                          });
                        },
                      )
                      : const SizedBox.shrink(),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.3),
                    child: ElevatedButton(
                      onPressed: () {
                        _startQuiz();
                      },
                      child: const Text(
                        'Start Quiz',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
