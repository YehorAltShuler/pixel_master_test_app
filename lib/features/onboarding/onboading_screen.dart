import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_master_test_app/core/common/widgets/health_track.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_font_styles.dart';
import '../../core/services/shared_preferences_service.dart';
import '../../init_dependencies.dart';
import '../../core/common/widgets/custom_button.dart';
import '../auth/presentation/pages/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routePath = '/onboarding';
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              serviceLocator<SharedPreferencesService>().isOnboardingComplete =
                  true;
              context.goNamed(AuthScreen.routeName);
            },
            child: Text(
              'Skip',
              style: AppFontStyles.h3(context).copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [
                OnboardingOne(),
                OnboardingTwo(),
                OnboardingThree(),
              ],
            ),
          ),
          Flexible(
            child: Center(
              child: CustomButton(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                height: 55,
                onPressed: () {
                  if (_currentIndex < 2) {
                    _pageController.nextPage(
                      duration: Durations.medium1,
                      curve: Curves.easeInOut,
                    );
                  } else {
                    serviceLocator<SharedPreferencesService>()
                        .isOnboardingComplete = true;
                    context.goNamed(AuthScreen.routeName);
                  }
                },
                child: Text(
                  _currentIndex < 2 ? 'Continue' : 'Get Started',
                  style: AppFontStyles.h2(context).copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HealthTrack(),
          Expanded(
            child: Image.asset(
              AppConstants.onboardingOne,
            ),
          ),
          Text(
            'Stay in Rhythm, Monitor Your Beat: Your Health, Your Pulse, Your Power!',
            textAlign: TextAlign.center,
            style: AppFontStyles.h3(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Monitor Your Health',
            textAlign: TextAlign.center,
            style: AppFontStyles.h0(context).copyWith(color: AppColors.white),
          ),
          Expanded(
            child: Image.asset(
              AppConstants.onboardingTwo,
            ),
          ),
          Text(
            'We provide an intuitive interface for tracking variations in blood pressure and pulse.',
            textAlign: TextAlign.center,
            style: AppFontStyles.h3(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ready to go?',
            textAlign: TextAlign.center,
            style: AppFontStyles.h0(context).copyWith(color: AppColors.white),
          ),
          Expanded(
            child: Image.asset(
              AppConstants.onboardingThree,
            ),
          ),
          Text(
            'Press "Get Started" and discover more about the capabilities of HealthTrack.',
            textAlign: TextAlign.center,
            style: AppFontStyles.h3(context).copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
