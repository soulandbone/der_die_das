import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ArticleToggleTile extends StatelessWidget {
  const ArticleToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Show Article in Question', style: TextStyle(fontSize: 16)),
          Gap(12),
          Icon(Icons.question_mark),
        ],
      ),
      trailing: Switch(
        value: currentState is DontShowArticle,
        onChanged: (value) {
          themeBloc.add(ToggleTheme());
        },
      ),
    );
  }
}
