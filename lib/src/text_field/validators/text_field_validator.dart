abstract class TextFieldValidator {
  TextFieldValidator(
      {this.regex,
      this.minLength,
      this.validationError,
      this.minLengthError,
      this.emptyError,
      this.mandatory,
      this.error});

  String? validationError;
  String? emptyError;
  String? minLengthError;
  String? error;
  RegExp? regex;
  double? minLength;
  bool? mandatory;

  String? validate(String? value) {
    if (error != null) {
      return error;
    }
    if (mandatory == true && (value?.isEmpty ?? true)) {
      return emptyError ?? validationError;
    }
    if (((value?.length ?? 0) < (minLength ?? 0))) {
      return minLengthError;
    }
    if (regex != null && value != null && !regex!.hasMatch(value)) {
      return validationError;
    }
    return null;
  }
}
