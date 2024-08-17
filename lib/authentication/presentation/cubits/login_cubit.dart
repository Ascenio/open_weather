import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginValidCredentials());
    await Future.delayed(const Duration(seconds: 2));
    if (email == 'admin@admin.com' && password == 'admin') {
      emit(const LoginValidCredentials());
    } else {
      emit(const LoginInvalidCredentials());
    }
  }
}
