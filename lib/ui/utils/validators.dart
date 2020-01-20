import 'dart:io';
import 'package:flutter/widgets.dart';

class Validators {
  static String Function(String) validateAlpha([String error]) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Name is required.';
      }
      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value)) {
        return error ?? 'Please enter only alphabetical characters.';
      }
      return null;
    };
  }

  static String Function(String) validateDouble([String error]) {
    return (String value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((double.tryParse(value) ?? 0.0) <= 0.0) {
        return error ?? 'Not a valid number.';
      }
      return null;
    };
  }

  static String Function(String) validateInt([String error]) {
    return (String value) {
      if (value == null || value.isEmpty) {
        return error ?? 'Field is required.';
      }
      if ((int.tryParse(value) ?? 0.0) <= 0) {
        return error ?? 'Not a valid number.';
      }
      return null;
    };
  }

  static String Function(String) validateEmail([String error]) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Email is required.';
      }
      if (!value.contains('@')) {
        return error ?? 'Not a valid email.';
      }
      return null;
    };
  }

  static String Function(String) validatePhone([String error]) {
    return (String value) {
      value = value.replaceFirst('+', '');
      if (value.isEmpty) {
        return error ?? 'Phone number is required.';
      }
      if (!RegExp(r'^\d+?$').hasMatch(value) ||
          !value.startsWith(RegExp("0[1789]")) ||
          // Land lines eg 01
          (value.startsWith("01") && value.length != 9) ||
          // Land lines eg 080
          (value.startsWith(RegExp("0[789]")) && value.length != 11)) {
        return error ?? 'Not a valid phone number.';
      }
      return null;
    };
  }

  static String Function(String) validateString([String error]) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return error ?? 'Field is required.';
      }
      return null;
    };
  }

  static String Function(String) validatePass([String error]) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'Password is required';
      } else if (value.length < 6 || value.length > 255) {
        return 'Password must be 6-255 characters';
      } else if (!_hasSpecialCharacter(value)) {
        return 'Password must contain atleast one special character';
      }
      return null;
    };
  }

  static String Function(String) validateSimplePassword([String error]) {
    return (String value) {
      if (value == null || value.isEmpty || value.trim().isEmpty) {
        return 'Password is required';
      } else if (value.length < 6 || value.length > 255) {
        return 'Password must be 6-255 characters';
      }
      return null;
    };
  }

  static String Function(File) validateFile([String error]) {
    return (File file) {
      if (file == null || file.path.isEmpty) {
        return error ?? 'Invalid File.';
      }
      return null;
    };
  }

  static String Function(String) validateAmount([String error]) {
    return (String value) {
      value = value.replaceAll(",", "");

      if (value.isEmpty) {
        return error ?? 'Amount is required.';
      }
      if (double.tryParse(value) == null) {
        return error ?? 'Invalid Amount.';
      }
      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
        return error ?? 'Not a valid amount.';
      }
      if (double.tryParse(value) <= 0.0) {
        return error ?? 'Zero Amount is not allowed.';
      }
      return null;
    };
  }

  static String Function(String) validateDiffChange(
    FormFieldState<String> field, [
    String error,
  ]) {
    return (String value) {
      if (field?.value != value) {
        return error ?? 'Values don\'t match';
      }
      return null;
    };
  }

  static String Function(String) validatePassword(
      FormFieldState<String> passwordField) {
    return (String value) {
      if (passwordField == null) {
        return 'Please enter a password.';
      }
      if (passwordField.value == null || passwordField.value.isEmpty) {
        return 'Please enter a password.';
      }
      return validateDiffChange(
        passwordField,
        'The passwords don\'t match',
      )(value);
    };
  }

  static bool _hasSpecialCharacter(String value) {
    var specialChars = "<>@!#\$%^&*()_+[]{}?:;|'\"\\,./~`-=";
    for (int i = 0; i < specialChars.length; i++) {
//      print(specialChars[i]);
      if (value.indexOf(specialChars[i]) > -1) {
        return true;
      }
    }
    return false;
  }
}
