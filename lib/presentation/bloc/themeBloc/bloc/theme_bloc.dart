import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ActiveTheme(ThemeModeType.light)) {
    on<ToggleTheme>(toggleTheme);
  }

  FutureOr<void> toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    if (state is ActiveTheme &&
        (state as ActiveTheme).mode == ThemeModeType.dark) {
      emit(ActiveTheme(ThemeModeType.light));
    } else if (state is ActiveTheme &&
        (state as ActiveTheme).mode == ThemeModeType.light) {
      emit(ActiveTheme(ThemeModeType.dark));
    }
  }
}
