import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/authentication/data/repositories/local_authentication_repository.dart';
import 'package:open_weather/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

void main() {
  late LocalAuthenticationRepository localAuthenticationRepository;

  setUp(() {
    localAuthenticationRepository = const LocalAuthenticationRepository();
  });

  test('returns true when when credentials are valid', () async {
    expect(
      await localAuthenticationRepository.authenticate(
        email: 'admin@admin.com',
        password: 'admin',
      ),
      isTrue,
    );
  });

  test('returns false when when credentials are invalid', () async {
    expect(
      await localAuthenticationRepository.authenticate(
        email: 'foo@example.com',
        password: 'bar',
      ),
      isFalse,
    );
  });
}
