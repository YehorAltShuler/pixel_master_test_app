import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/core/utils/auth_helpers.dart';
import 'package:pixel_master_test_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font_styles.dart';
import '../../../../core/common/widgets/custom_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.nameController,
      required this.authPageController});

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final PageController authPageController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildText(context),
          const SizedBox(height: 32),
          _buildForm(context),
          _buildSignUpButton(context),
        ],
      ),
    );
  }

  _buildText(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return Column(
      children: [
        Text(
          'Sign Up',
          style: AppFontStyles.h1(context),
        ),
        const SizedBox(height: 12),
        Text(
          'Input your information to create an account.',
          style: AppFontStyles.h3(context).copyWith(
            color: brightness == Brightness.dark
                ? AppColors.white
                : AppColors.black,
          ),
        ),
        _buildSignInTextSpan(context),
      ],
    );
  }

  _buildForm(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 2),
              child: Text(
                'Name',
                style: AppFontStyles.h3(context).copyWith(
                  color: brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),
            ),
            TextFormField(
              validator: (name) => AuthHelpers.nameValidator(name),
              controller: widget.nameController,
              decoration: const InputDecoration(
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 2),
              child: Text(
                'Email',
                style: AppFontStyles.h3(context).copyWith(
                  color: brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),
            ),
            TextFormField(
              validator: (email) => AuthHelpers.emailValidator(email),
              controller: widget.emailController,
              decoration: const InputDecoration(
                hintText: 'Enter email',
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 2),
              child: Text(
                'Password',
                style: AppFontStyles.h3(context).copyWith(
                  color: brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),
            ),
            TextFormField(
              validator: (value) => AuthHelpers.passwordValidator(value),
              controller: widget.passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                hintText: 'Enter password',
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 2),
              child: Text(
                'Confirm password',
                style: AppFontStyles.h3(context).copyWith(
                  color: brightness == Brightness.dark
                      ? AppColors.white
                      : AppColors.black,
                ),
              ),
            ),
            TextFormField(
              validator: (value) => AuthHelpers.confirmPasswordValidator(
                value,
                widget.passwordController,
              ),
              controller: widget.confirmPasswordController,
              obscureText: confirmPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Confirm password',
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    confirmPasswordVisible = !confirmPasswordVisible;
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSignUpButton(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return CustomButton(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
      child: Text(
        'Sign Up',
        style: AppFontStyles.h2(context).copyWith(
          color: AppColors.white,
        ),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          authBloc.add(AuthSignUp(
            name: widget.nameController.text.trim(),
            email: widget.emailController.text.trim(),
            password: widget.passwordController.text.trim(),
          ));
        }
      },
    );
  }

  _buildSignInTextSpan(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account? ',
            style: AppFontStyles.h3(context).copyWith(
              color: brightness == Brightness.dark
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
          TextSpan(
            text: 'Sign in',
            style: AppFontStyles.h3(context).copyWith(
              color: AppColors.nice2Color,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.authPageController.previousPage(
                    duration: Durations.medium1, curve: Curves.easeInOut);
              },
          ),
        ],
      ),
    );
  }
}
