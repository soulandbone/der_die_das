import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Dark mode', style: TextStyle(fontSize: 16)),
          Gap(12),
          Icon(Icons.dark_mode_outlined),
        ],
      ),
      trailing: Switch(
        value: (currentState as Settings).isDark,
        onChanged: (value) {
          themeBloc.add(ToggleTheme());
        },
      ),
    );
  }
}
