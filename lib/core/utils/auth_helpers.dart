class AuthHelpers {
  static String? nameValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'The name must contain at least 3 characters';
    }
    return null;
  }

  static String? emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!_isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'The password must contain at least 6 characters';
    }
    return null;
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value.length < 6) {
      return 'The password must contain at least 6 characters';
    }
    if (value != passwordController.text) {
      return 'The passwords do not match';
    }
    return null;
  }

  static bool _isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }
}
