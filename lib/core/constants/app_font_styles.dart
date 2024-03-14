import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFontStyles {
  static TextStyle h0(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          )
        : const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          );

    // const TextStyle(
    //     fontSize: 32,
    //     fontWeight: FontWeight.w700,
    //     color: AppColors.white,
    //   )
    // : const TextStyle(
    //     fontSize: 32,
    //     fontWeight: FontWeight.w700,
    //     color: AppColors.black,
    //   );
  }

  static TextStyle h1(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          )
        : const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          );

    // const TextStyle(
    //     fontSize: 24,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.white,
    //   )
    // : const TextStyle(
    //     fontSize: 24,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.black,
    //   );
  }

  static TextStyle h2(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          )
        : const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          );

    // const TextStyle(
    //     fontSize: 17,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.white,
    //   )
    // : const TextStyle(
    //     fontSize: 17,
    //     fontWeight: FontWeight.w600,
    //     color: AppColors.black,
    //   );
  }

  static TextStyle h3(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          )
        : const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          );

    // const TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.black,
    //   )
    // : const TextStyle(
    //     fontSize: 16,
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.white,
    //   );
  }

  static TextStyle h4(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          )
        : const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          );

    // const TextStyle(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.white,
    //   )
    // : const TextStyle(
    //     fontSize: 14,
    //     fontWeight: FontWeight.w500,
    //     color: AppColors.black,
    //   );
  }
}
