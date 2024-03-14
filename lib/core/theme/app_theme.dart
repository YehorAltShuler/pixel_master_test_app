import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(shape: CircleBorder()),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      datePickerTheme: DatePickerThemeData(
        dividerColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        dayPeriodColor: AppColors.primary,
        dayPeriodBorderSide: const BorderSide(
          color: AppColors.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.grey4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.white1,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
      // switchTheme: SwitchThemeData(
      //   thumbColor: MaterialStateProperty.all(AppColors.white),
      //   trackColor: MaterialStateProperty.all(AppColors.orange300),
      // ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.dark,
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(
      //     foregroundColor: MaterialStateProperty.all(AppColors.grey100),
      //   ),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          foregroundColor: MaterialStateProperty.all(AppColors.primary),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
      textTheme: const TextTheme(),
      scaffoldBackgroundColor: AppColors.bgWhite,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(shape: CircleBorder()),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      datePickerTheme: DatePickerThemeData(
        dividerColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.black,
        dayPeriodColor: AppColors.primary,
        dayPeriodBorderSide: const BorderSide(
          color: AppColors.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.dark,
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.darkGrey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
        ),
      ),
      //   switchTheme: SwitchThemeData(
      //     trackOutlineColor: MaterialStateProperty.all(AppColors.orange300),
      //     thumbColor: MaterialStateProperty.all(AppColors.orange300),
      //     trackColor: MaterialStateProperty.all(AppColors.dark300),
      //   ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.dark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightGrey,
      ),
      //   textButtonTheme: TextButtonThemeData(
      //     style: ButtonStyle(
      //       foregroundColor: MaterialStateProperty.all(AppColors.orange300),
      //     ),
      //   ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.black),
          foregroundColor: MaterialStateProperty.all(AppColors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ),
      textTheme: const TextTheme(),
      scaffoldBackgroundColor: AppColors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.black,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        brightness: Brightness.dark,
      ),
    );
  }
}
