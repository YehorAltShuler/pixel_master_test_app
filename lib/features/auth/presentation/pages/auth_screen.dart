import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_master_test_app/core/common/widgets/loader.dart';
import 'package:pixel_master_test_app/core/utils/show_snackbar.dart';
import 'package:pixel_master_test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pixel_master_test_app/features/health_records/presentation/pages/pulse_and_pressure.dart';
import 'package:pixel_master_test_app/core/common/widgets/health_track.dart';

import '../widgets/sign_in_form.dart';
import '../widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  static const String routePath = '/auth';
  static const String routeName = 'auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authPageController = PageController(initialPage: 0);
  int authPageIndex = 0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccess) {
          showSuccessSnackBar(context, 'Signed in successfully!');
          context.goNamed(PulseAndPressure.routeName);
        }
        if (state is AuthFailure) {
          showErrorSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(
              child: HealthTrack(),
            ),
            Expanded(
              flex: 3,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    showSuccessSnackBar(context, 'Signed in successfully!');
                    context.goNamed(PulseAndPressure.routeName);
                  }
                  if (state is AuthFailure) {
                    showErrorSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Loader();
                  }
                  return PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: authPageController,
                    onPageChanged: (index) {
                      authPageIndex = index;
                    },
                    children: [
                      SignInForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        authPageController: authPageController,
                      ),
                      SignUpForm(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        authPageController: authPageController,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
