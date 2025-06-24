import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/drawer/main_drawer.dart';
import 'package:der_die_das/presentation/widgets/mainMenu/ListWheel/custom_menu_toggle.dart';
import 'package:der_die_das/presentation/widgets/mainMenu/main_menu_toggle.dart';
import 'package:der_die_das/presentation/widgets/welcome_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isTimed = true;
  int timedSelection = 0;
  int untimedSelection = 0;
  int customSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['1', '2', '3'];

    return Scaffold(
      appBar: AppBar(title: Text('Der,Die,Das')),
      drawer: MainDrawer(),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuestionsLoaded) {
            return Column(
              children: [
                WelcomeBanner(),
                Gap(40),
                MainMenuToggle(
                  labels: ['Timed', 'Untimed'],
                  function: (index) {
                    setState(() {
                      isTimed = index == 0;
                    });
                  },
                ),
                Gap(15),
                isTimed
                    ? MainMenuToggle(
                      key: ValueKey('timed'),
                      labels: ['30 secs', '60 secs', '120 secs', 'Custom'],
                      function: (index) {
                        setState(() {
                          timedSelection = index;
                        });
                      },
                    )
                    : MainMenuToggle(
                      key: ValueKey('untimed'),
                      labels: [
                        '10 questions',
                        '25 questions',
                        '50 questions',
                        'Custom',
                      ],
                      function: (int index) {
                        setState(() {
                          untimedSelection = index;
                        });
                      },
                    ),
                Gap(15),
                CustomMenuToggle(
                  options: options,
                  selectedIndex: customSelectedIndex,
                  onChanged: (int index) {
                    setState(() {
                      customSelectedIndex = index;
                    });
                    print('Selected index is $index');
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
