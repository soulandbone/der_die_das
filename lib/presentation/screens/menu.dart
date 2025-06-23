import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/widgets/drawer/main_drawer.dart';
import 'package:der_die_das/presentation/widgets/mainMenu/main_menu_toggle.dart';
import 'package:der_die_das/presentation/widgets/welcome_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                MainMenuToggle(labels: ['Option1', 'Option2', 'Option3']),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
