import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/core/services/shared_preferences_service.dart';

import '../../../init_dependencies.dart';
import '../app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  ThemeData get theme {
    switch (state.themeType) {
      case ThemeType.light:
        return AppTheme.lightTheme();
      case ThemeType.dark:
        return AppTheme.darkTheme();
      case ThemeType.system:
        Brightness brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;

        switch (brightness) {
          case Brightness.light:
            return AppTheme.lightTheme();
          case Brightness.dark:
            return AppTheme.darkTheme();
        }
    }
  }

  /// Switches the theme to the opposite one.
  void switchTheme() {
    switch (state.themeType) {
      case ThemeType.light:
        changeTheme(ThemeType.dark);
        break;
      case ThemeType.dark:
        changeTheme(ThemeType.light);
        break;
      case ThemeType.system:
        Brightness brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;

        switch (brightness) {
          case Brightness.light:
            changeTheme(ThemeType.dark);
          case Brightness.dark:
            changeTheme(ThemeType.light);
        }
        break;
    }
  }

  /// Changes the theme to the specified one.
  void changeTheme(ThemeType themeType) {
    serviceLocator<SharedPreferencesService>().themeType = themeType.name;
    emit(state.copyWith(themeType: themeType));
  }
}
