import 'package:der_die_das/presentation/bloc/themeBloc/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<ThemeBloc>().state;
    final themeBloc = context.read<ThemeBloc>();

    return ListTile(
      leading: Text('Light mode', style: TextStyle(fontSize: 16)),
      trailing: Switch(
        value: currentState.runtimeType == LightTheme,
        onChanged: (value) {
          themeBloc.add(ToggleTheme());
        },
      ),
    );
  }
}
