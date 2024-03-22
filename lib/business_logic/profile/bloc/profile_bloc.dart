import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/repositories/auth/authrepo.dart';
import 'package:crocs_club/utils/functions.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository = AuthRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetched>((event, emit) async {
      try {
        final token = await getToken();
        // Replace with your token retrieval logic
        print('token is $token');
        final data = await authRepository.getUserProfile(token!);
        emit(ProfileLoaded(profileData: data));
      } catch (error) {
        emit(ProfileError(error: error.toString()));
      }
    });
  }
}
