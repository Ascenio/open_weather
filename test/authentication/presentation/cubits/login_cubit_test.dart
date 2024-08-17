import 'package:bloc_test/bloc_test.dart';
import 'package:open_weather/authentication/presentation/cubits/login_cubit.dart';
import 'package:open_weather/authentication/presentation/cubits/login_state.dart';

void main() {
  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginInvalidCredentials] when credentials are invalid',
    build: () => LoginCubit(),
    act: (cubit) => cubit.login(email: 'foo@bar.com', password: 'baz'),
    expect: () => const <LoginState>[
      LoginLoading(),
      LoginInvalidCredentials(),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginInvalidCredentials] when credentials are valid',
    build: () => LoginCubit(),
    act: (cubit) => cubit.login(email: 'admin@admin.com', password: 'admin'),
    expect: () => const <LoginState>[
      LoginLoading(),
      LoginValidCredentials(),
    ],
  );
}
