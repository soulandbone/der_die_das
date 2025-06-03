part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class DarkTheme extends ThemeState {}

final class LightTheme extends ThemeState {}
