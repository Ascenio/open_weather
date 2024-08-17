import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather/authentication/domain/repositories/authentication_repository.dart';
import 'package:open_weather/authentication/presentation/cubits/login_cubit.dart';
import 'package:open_weather/authentication/presentation/cubits/login_state.dart';

class AuthenticationRepositoryMock extends Mock
    implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository authenticationRepository;
  late LoginCubit cubit;

  setUp(() {
    authenticationRepository = AuthenticationRepositoryMock();
    cubit = LoginCubit(authenticationRepository: authenticationRepository);
  });

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginInvalidCredentials] when credentials are invalid',
    build: () => cubit,
    setUp: () {
      when(
        () => authenticationRepository.authenticate(
          email: 'foo@bar.com',
          password: 'baz',
        ),
      ).thenAnswer((_) async => false);
    },
    act: (cubit) => cubit.login(email: 'foo@bar.com', password: 'baz'),
    expect: () => const <LoginState>[
      LoginLoading(),
      LoginInvalidCredentials(),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginInvalidCredentials] when credentials are valid',
    build: () => cubit,
    setUp: () {
      when(
        () => authenticationRepository.authenticate(
          email: 'admin@admin.com',
          password: 'admin',
        ),
      ).thenAnswer((_) async => true);
    },
    act: (cubit) => cubit.login(email: 'admin@admin.com', password: 'admin'),
    expect: () => const <LoginState>[
      LoginLoading(),
      LoginValidCredentials(),
    ],
  );
}
