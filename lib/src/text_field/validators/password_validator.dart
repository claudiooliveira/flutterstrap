import 'package:flutterstrap/flutterstrap.dart';

class PasswordValidator extends TextFieldValidator {
  PasswordValidator({
    RegExp? regex,
    double? minLength,
    String? validationError =
        'Your password must contain uppercase, lowercase, numbers and special characters.',
    String? minLengthError,
    String? emptyError,
    bool? mandatory = true,
    String? error,
  }) : super(
          regex: regex ??
              RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&]*$'),
          minLength: minLength,
          validationError: validationError,
          minLengthError: minLengthError,
          emptyError: emptyError,
          mandatory: mandatory,
          error: error,
        );
}
