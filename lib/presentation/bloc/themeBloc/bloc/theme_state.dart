part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class Settings extends ThemeState {
  Settings({required this.isDark, required this.showsArticle});
  final bool isDark;
  final bool showsArticle;
}
