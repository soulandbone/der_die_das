import 'package:der_die_das/presentation/bloc/questionBloc/question_bloc.dart';
import 'package:der_die_das/presentation/screens/menu.dart';
import 'package:der_die_das/presentation/widgets/drawer/article_toggle_tile.dart';
import 'package:der_die_das/presentation/widgets/drawer/toggle_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final quizBloc = context.read<QuestionBloc>();
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Der, Die, Das',
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    fontSize: 26,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
          ),
          ToggleTile(),
          ArticleToggleTile(),
          Divider(),
          ListTile(
            title: InkWell(
              onTap: () {
                quizBloc.add(ReturnToMainMenu());
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              child: Text(
                'Main Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surfaceTint,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
