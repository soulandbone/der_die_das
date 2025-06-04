import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(Settings(isDark: false, showsArticle: false)) {
    on<ToggleTheme>(toggleTheme);
    on<ToggleShowArticle>(toggleShowArticle);
  }

  FutureOr<void> toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final currentState = (state as Settings);
    final isDark = currentState.isDark;
    final showsArticle = currentState.showsArticle;

    emit(Settings(isDark: !isDark, showsArticle: showsArticle));
  }

  FutureOr<void> toggleShowArticle(
    ToggleShowArticle event,
    Emitter<ThemeState> emit,
  ) {
    final currentState = (state as Settings);
    final isDark = currentState.isDark;
    final showsArticle = currentState.showsArticle;
    emit(Settings(isDark: isDark, showsArticle: !showsArticle));
  }
}
