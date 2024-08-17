import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/non_empty_validator.dart';

void main() {
  const errorMessage = 'Please provide some text';

  test('should return an error on empty texts', () {
    final validator = nonEmptyValidator(message: errorMessage);
    expect(validator(''), errorMessage);
  });

  test('should not return an error on filled text', () {
    final validator = nonEmptyValidator(message: errorMessage);
    expect(validator('hi'), isNull);
  });

  test('should not return an error on null text', () {
    final validator = nonEmptyValidator(message: errorMessage);
    expect(validator(null), isNull);
  });
}
