import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ToggleTheme>(toggleTheme);
    on<ToggleShowArticle>(toggleShowArticle);
  }

  FutureOr<void> toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    if (state is LightTheme) {
      emit(DarkTheme());
    } else if (state is DarkTheme) {
      emit(LightTheme());
    }
  }

  FutureOr<void> toggleShowArticle(
    ToggleShowArticle event,
    Emitter<ThemeState> emit,
  ) {
    if (state is ShowArticle) {
      emit(DontShowArticle());
    } else if (state is DontShowArticle) {
      emit(ShowArticle());
    }
  }
}
