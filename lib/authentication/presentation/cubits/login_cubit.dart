import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather/authentication/domain/repositories/authentication_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authenticationRepository,
  }) : super(const LoginInitial());

  final AuthenticationRepository authenticationRepository;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());
    final authenticated = await authenticationRepository.authenticate(
      email: email,
      password: password,
    );
    if (authenticated) {
      emit(const LoginValidCredentials());
    } else {
      emit(const LoginInvalidCredentials());
    }
  }
}
