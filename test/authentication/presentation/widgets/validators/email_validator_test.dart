import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/authentication/presentation/widgets/validators/email_validator.dart';

void main() {
  const errorMessage = 'Please provide a valid email';

  test('should return error when the email does not contains "@"', () {
    expect(emailValidator('foogmail.com'), errorMessage);
  });

  test('should return no error when email contains "@"', () {
    expect(emailValidator('foo@gmail.com'), isNull);
  });
}
