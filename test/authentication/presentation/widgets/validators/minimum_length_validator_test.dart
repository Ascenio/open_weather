import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/minimum_length_validator.dart';

void main() {
  const length = 5;
  const fieldName = 'password';
  const errorMessage = 'Please provide a password of at least 5 characters';

  test('should return error when length is lower than the threshold', () {
    final validator = minimumLengthValidator(
      fieldName: fieldName,
      length: length,
    );
    expect(validator('abcd'), errorMessage);
  });

  test('should return no error when length is equal to the threshold', () {
    final validator = minimumLengthValidator(
      fieldName: fieldName,
      length: length,
    );
    expect(validator('abcde'), isNull);
  });

  test('should return error when length is greater than the threshold', () {
    final validator = minimumLengthValidator(
      fieldName: fieldName,
      length: length,
    );
    expect(validator('abcdef'), isNull);
  });
}
