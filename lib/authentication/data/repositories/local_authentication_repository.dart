import 'package:open_weather/authentication/domain/repositories/authentication_repository.dart';

final class LocalAuthenticationRepository implements AuthenticationRepository {
  const LocalAuthenticationRepository();

  @override
  Future<bool> authenticate({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return email == 'admin@admin.com' && password == 'admin';
  }
}
