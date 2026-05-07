import 'package:easy_localization/easy_localization.dart';

import '../../generated/app_strings.g.dart';

mixin FormValidationMixin {
  final _passwordRegEx = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  final _upperCaseRegEx = RegExp(r'[A-Z]');

  final _lowerCaseRegEx = RegExp(r'[a-z]');

  final _numberRegEx = RegExp(r'[0-9]');

  final _emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  final _mobileRegEx = RegExp(r'^[0-9]{10}$');

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyUserNameHint.tr();
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyMobileHint.tr();
    }
    if (!_mobileRegEx.hasMatch(value)) {
      return LocaleKeys.notValidMobileHint.tr();
    }
    return null;
  }

  String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyFieldHint.tr();
    }
    if (!_numberRegEx.hasMatch(value)) {
      return LocaleKeys.notValidNumberHint.tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyEmailHint.tr();
    }
    if (!_emailRegEx.hasMatch(value)) {
      return LocaleKeys.notValidEmailHint.tr();
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyPasswordHint.tr();
    }

    if (value.length < 5) {
      return LocaleKeys.passwordValidateLengthHint.tr(args: ['5']);
    }

    if (!value.contains(_upperCaseRegEx)) {
      // return 'Password must contain at least 1 uppercase letter';
      return null;
    }

    if (!value.contains(_lowerCaseRegEx)) {
      // return 'Password must contain at least 1 lowercase letter';
      return null;
    }

    if (!value.contains(_numberRegEx)) {
      // return 'Password must contain at least 1 number';
      return null;
    }

    if (!_passwordRegEx.hasMatch(value)) {
      // return 'Password must contain at least 1 uppercase letter, 1 lowercase letter and 1 number';
      return null;
    }
    return null;
  }

  String? validateLength({
    required String? value,
    required int minLength,
    required int maxLength,
  }) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.emptyFieldHint.tr();
    }
    if (value.length < minLength) {
      return LocaleKeys.minValidateHint.tr(args: [minLength.toString()]);
    }
    if (value.length > maxLength) {
      return LocaleKeys.maxValidateHint.tr(args: [maxLength.toString()]);
    }
    return null;
  }

  String? validateEmailOrPhone(String? value) {
    final emailError = validateEmail(value);
    final mobileError = validateMobile(value);
    if (emailError != null && mobileError != null) {
      return "${LocaleKeys.notValidEmailHint.tr()} ${LocaleKeys.or.tr()} ${LocaleKeys.notValidMobileHint.tr()}";
    }
    return null;
  }

  String? validateConfirmPassword({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return LocaleKeys.emptyConfirmPasswordHint.tr();
    }

    if (password != confirmPassword) {
      return LocaleKeys.passwordNotMatchHint.tr();
    }

    return null;
  }
}
