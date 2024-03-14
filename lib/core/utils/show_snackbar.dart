import 'package:flutter/material.dart';

import '../common/widgets/custom_snack_bar.dart';

void showSuccessSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      CustomSnackBar.successSnackBar(
        context,
        content: content,
      ),
    );
}

void showErrorSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      CustomSnackBar.errorSnackBar(
        context,
        content: content,
      ),
    );
}
