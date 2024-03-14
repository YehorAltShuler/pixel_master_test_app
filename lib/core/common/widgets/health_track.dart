import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class HealthTrack extends StatelessWidget {
  const HealthTrack({super.key, this.fontSize = 40});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcATop, // Устанавливаем режим смешивания
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                AppColors.nice2Color,
                AppColors.primary,
                AppColors.primary
              ], // Цвета градиента
              begin: Alignment.topCenter, // Начальная точка градиента
              end: Alignment.bottomCenter, // Конечная точка градиента
            ).createShader(bounds);
          },
          child: RichText(
            text: TextSpan(
              text: 'HealthTrack',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Text(
          'Pulse & Pressure',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize / 2,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
