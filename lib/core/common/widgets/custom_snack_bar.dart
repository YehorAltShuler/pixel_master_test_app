import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_styles.dart';

class CustomSnackBar {
  static SnackBar successSnackBar(BuildContext context,
      {required String content}) {
    final Brightness brightness = Theme.of(context).brightness;
    return SnackBar(
      content: Text(
        content,
        style: AppFontStyles.h3(context),
      ),
      backgroundColor:
          brightness == Brightness.dark ? AppColors.dark : AppColors.white,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.successGreen, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  static SnackBar errorSnackBar(BuildContext context,
      {required String content}) {
    final Brightness brightness = Theme.of(context).brightness;
    return SnackBar(
      content: Text(
        content,
        style: AppFontStyles.h3(context),
      ),
      backgroundColor:
          brightness == Brightness.dark ? AppColors.dark : AppColors.white,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.errorRed, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
