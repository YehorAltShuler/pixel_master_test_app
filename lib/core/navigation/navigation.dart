import 'package:go_router/go_router.dart';
import 'package:pixel_master_test_app/core/services/shared_preferences_service.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/pages/add_new_record.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/pages/history.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/pages/pulse_and_pressure.dart';
import 'package:pixel_master_test_app/init_dependencies.dart';

import '../../features/auth/presentation/pages/auth_screen.dart';
import '../../features/onboarding/onboading_screen.dart';

class Navigation {
  static final GoRouter routerConfig = GoRouter(
    initialLocation: PulseAndPressure.routePath,
    routes: <RouteBase>[
      // GoRoute(
      //   name: HomeScreen.routeName,
      //   path: HomeScreen.routePath,
      //   builder: (context, state) {
      //     return const HomeScreen();
      //   },
      //   routes: const [
      //     // TODO router config for nested routes
      //   ],
      // ),
      GoRoute(
        name: PulseAndPressure.routeName,
        path: PulseAndPressure.routePath,
        redirect: (context, state) async {
          final prefs = serviceLocator<SharedPreferencesService>();
          if (prefs.isOnboardingComplete == false &&
              prefs.isUserLoggedIn == false) {
            return OnboardingScreen.routePath;
          }
          if (prefs.isOnboardingComplete == true &&
              prefs.isUserLoggedIn == false) {
            return AuthScreen.routePath;
          }
          return null;
        },
        builder: (context, state) {
          return const PulseAndPressure();
        },
        routes: [
          GoRoute(
            name: AddNewRecord.routeName,
            path: AddNewRecord.routePath,
            builder: (context, state) {
              return const AddNewRecord();
            },
            routes: const [
              // TODO router config for nested routes
            ],
          ),
          GoRoute(
            name: History.routeName,
            path: History.routePath,
            builder: (context, state) {
              return const History();
            },
            routes: const [
              // TODO router config for nested routes
            ],
          ),
        ],
      ),
      GoRoute(
        name: OnboardingScreen.routeName,
        path: OnboardingScreen.routePath,
        builder: (context, state) {
          return const OnboardingScreen();
        },
        routes: const [
          // TODO router config for nested routes
        ],
      ),
      GoRoute(
        name: AuthScreen.routeName,
        path: AuthScreen.routePath,
        builder: (context, state) {
          return const AuthScreen();
        },
        routes: const [
          // TODO router config for nested routes
        ],
      ),

      // TODO router config for other routes
    ],
  );
}
