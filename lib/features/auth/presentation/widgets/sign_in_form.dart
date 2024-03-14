import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_master_test_app/core/utils/auth_helpers.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font_styles.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../bloc/auth_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.authPageController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final PageController authPageController;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildText(context),
          const SizedBox(height: 32),
          _buildForm(context),
          _buildSignInButton(context),
        ],
      ),
    );
  }

  _buildText(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return Column(
      children: [
        Text(
          'Sign In',
          style: AppFontStyles.h1(context),
        ),
        const SizedBox(height: 12),
        Text(
          'Input your information to log in.',
          style: AppFontStyles.h3(context).copyWith(
            color: brightness == Brightness.dark
                ? AppColors.white
                : AppColors.black,
          ),
        ),
        _buildSignUpTextSpan(context),
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
          ],
        ),
      ),
    );
  }

  _buildSignInButton(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return CustomButton(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
      child: Text(
        'Sign In',
        style: AppFontStyles.h2(context).copyWith(
          color: AppColors.white,
        ),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          authBloc.add(AuthSignIn(
            email: widget.emailController.text.trim(),
            password: widget.passwordController.text.trim(),
          ));
        }
      },
    );
  }

  _buildSignUpTextSpan(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account? ',
            style: AppFontStyles.h3(context).copyWith(
              color: brightness == Brightness.dark
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: AppFontStyles.h3(context).copyWith(
              color: AppColors.nice2Color,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.authPageController.nextPage(
                    duration: Durations.medium1, curve: Curves.easeInOut);
              },
          ),
        ],
      ),
    );
  }
}
