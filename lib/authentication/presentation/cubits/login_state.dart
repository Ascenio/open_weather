import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginValidCredentials extends LoginState {
  const LoginValidCredentials();
}

final class LoginInvalidCredentials extends LoginState {
  const LoginInvalidCredentials();
}
