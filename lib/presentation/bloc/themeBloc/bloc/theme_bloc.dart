import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, Settings> {
  ThemeBloc() : super(Settings(isDark: false, showsArticle: false)) {
    on<ToggleTheme>(toggleTheme);
    on<ToggleShowArticle>(toggleShowArticle);
  }

  void toggleTheme(ToggleTheme _, Emitter<Settings> emit) {
    final isDark = state.isDark;

    emit(state.copyWith(isDark: !isDark));
  }

  void toggleShowArticle(ToggleShowArticle _, Emitter<Settings> emit) {
    final showsArticle = state.showsArticle;
    emit(state.copyWith(showsArticle: !showsArticle));
  }
}
