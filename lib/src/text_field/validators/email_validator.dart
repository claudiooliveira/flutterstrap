import 'package:flutterstrap/flutterstrap.dart';

class EmailValidator extends TextFieldValidator {
  EmailValidator({
    String? validationError = 'Please enter a valid email.',
    String? emptyError,
    bool? mandatory = true,
  }) : super(
          regex: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
          validationError: validationError,
          emptyError: emptyError,
          mandatory: mandatory,
        );
}
