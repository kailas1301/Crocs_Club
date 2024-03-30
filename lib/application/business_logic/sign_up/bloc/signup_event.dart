part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  SignupButtonPressed({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });
}
