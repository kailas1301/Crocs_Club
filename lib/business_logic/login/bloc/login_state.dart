part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFormInvalid extends LoginState {
  final String? error;

  LoginFormInvalid({required this.error});
}

class LoginSuccessful extends LoginState {
  final String message;

  LoginSuccessful(this.message);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}
