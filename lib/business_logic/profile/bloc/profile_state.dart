part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;
  ProfileLoaded({required this.profileData});
}

class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}
