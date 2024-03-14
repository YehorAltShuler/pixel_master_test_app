part of 'theme_cubit.dart';

enum ThemeType {
  light,
  dark,
  system;

  String get name {
    switch (this) {
      case ThemeType.light:
        return 'light';
      case ThemeType.dark:
        return 'dark';
      case ThemeType.system:
        return 'system';
    }
  }

  static ThemeType fromName(String name) {
    switch (name) {
      case 'light':
        return ThemeType.light;
      case 'dark':
        return ThemeType.dark;
      case 'system':
        return ThemeType.system;
      default:
        return ThemeType.system;
    }
  }
}

@immutable
class ThemeState extends Equatable {
  final ThemeType themeType;

  const ThemeState({
    this.themeType = ThemeType.system,
  });

  @override
  List<Object> get props => [
        themeType,
      ];

  ThemeState copyWith({
    ThemeType? themeType,
  }) {
    return ThemeState(
      themeType: themeType ?? this.themeType,
    );
  }
}
