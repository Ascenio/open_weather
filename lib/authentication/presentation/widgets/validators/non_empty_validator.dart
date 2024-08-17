import 'package:flutter/material.dart';

FormFieldValidator<String> nonEmptyValidator({required String message}) {
  return (value) {
    if (value == null) {
      return null;
    }
    return value.isEmpty ? message : null;
  };
}
