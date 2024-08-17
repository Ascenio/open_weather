import 'package:flutter/material.dart';

FormFieldValidator<String> minimumLengthValidator({
  required int length,
  required String fieldName,
}) {
  return (value) {
    if (value == null) {
      return null;
    }
    if (value.length >= length) {
      return null;
    }
    return 'Please provide a $fieldName of at least $length characters';
  };
}
