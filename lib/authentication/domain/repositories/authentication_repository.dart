abstract interface class AuthenticationRepository {
  Future<bool> authenticate({required String email, required String password});
}
