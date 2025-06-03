part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

enum ThemeModeType { dark, light }

final class ActiveTheme extends ThemeState {
  ActiveTheme(this.mode);
  final ThemeModeType mode;
}
