import 'package:flutter/material.dart';

FormFieldValidator<String> compositeValidator({
  required List<FormFieldValidator<String>> validators,
}) {
  return (value) {
    return validators.map((validator) => validator(value)).firstWhere(
          (result) => result != null,
          orElse: () => null,
        );
  };
}
