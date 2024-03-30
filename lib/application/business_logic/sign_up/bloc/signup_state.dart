part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class SignUpLoading extends SignupState {}

class SignUpFormInvalid extends SignupState {
  final String? error;

  SignUpFormInvalid({required this.error});
}

class SignUpSuccessful extends SignupState {
  final String message;

  SignUpSuccessful(this.message);
}

class SignUpError extends SignupState {
  final String error;

  SignUpError(this.error);
}
