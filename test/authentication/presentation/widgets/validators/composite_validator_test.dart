import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/composite_validator.dart';

void main() {
  String? alwaysSucceedsValidator(String? _) => null;
  FormFieldValidator<String> alwaysFailsValidator({required String message}) {
    return (_) => message;
  }

  test('should return no error when all validators pass', () {
    final validator = compositeValidator(validators: [
      alwaysSucceedsValidator,
      alwaysSucceedsValidator,
      alwaysSucceedsValidator
    ]);
    expect(
      validator('some text'),
      isNull,
    );
  });

  test('should return error when any validator fails', () {
    final validator = compositeValidator(validators: [
      alwaysSucceedsValidator,
      alwaysFailsValidator(message: 'error'),
      alwaysSucceedsValidator
    ]);
    expect(
      validator('some text'),
      'error',
    );
  });

  test('should return the first error found', () {
    final validator = compositeValidator(validators: [
      alwaysSucceedsValidator,
      alwaysFailsValidator(message: 'error'),
      alwaysFailsValidator(message: 'another error'),
    ]);
    expect(
      validator('some text'),
      'error',
    );
  });
}
