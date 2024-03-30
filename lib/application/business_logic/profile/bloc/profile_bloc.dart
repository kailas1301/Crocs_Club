import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/auth/authrepo.dart';
import 'package:crocs_club/data/sharedpreference/shared_preference.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository = AuthRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetched>((event, emit) async {
      try {
        final token = await getToken();
        final data = await authRepository.getUserProfile(token!);
        emit(ProfileLoaded(profileData: data));
      } catch (error) {
        emit(ProfileError(error: error.toString()));
      }
    });
  }
}
