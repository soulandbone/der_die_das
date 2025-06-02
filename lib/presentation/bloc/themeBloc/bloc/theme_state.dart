part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  // ThemeInitial(this.darkTheme);
  // final ThemeData darkTheme;
}

final class DarkTheme extends ThemeState {}

final class LightTheme extends ThemeState {}
