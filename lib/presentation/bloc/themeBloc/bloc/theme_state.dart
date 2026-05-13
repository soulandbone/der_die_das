part of 'theme_bloc.dart';

@immutable
class Settings {
  const Settings({required this.isDark, required this.showsArticle});
  final bool isDark;
  final bool showsArticle;

  Settings copyWith({bool? isDark, bool? showsArticle}) {
    return Settings(
      isDark: isDark ?? this.isDark,
      showsArticle: showsArticle ?? this.showsArticle,
    );
  }
}
