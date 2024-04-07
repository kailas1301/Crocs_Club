part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileFetched extends ProfileEvent {}

class ProfileEditRequested extends ProfileEvent {
  final UserProfile editedProfile;

  ProfileEditRequested({required this.editedProfile});
}
