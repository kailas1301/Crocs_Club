import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/services/userprofile/userprofile_services.dart';
import 'package:crocs_club/domain/models/profile_model.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserProfileServices userprofileservice = UserProfileServices();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetched>((event, emit) async {
      try {
        final data = await userprofileservice.getUserProfile();
        emit(ProfileLoaded(profileData: data));
      } catch (error) {
        emit(ProfileError(error: error.toString()));
      }
    });

    on<ProfileEditRequested>((event, emit) async {
      emit(ProfileLoading());
      try {
        final response =
            await userprofileservice.updateUserProfile(event.editedProfile);
        if (response == 'success') {
          final data = await userprofileservice.getUserProfile();
          emit(ProfileLoaded(profileData: data));
          emit(ProfileUpdated());
        } else {
          emit(ProfileError(error: 'Update was not successfull'));
        }
      } catch (e) {
        rethrow;
      }
    });
  }
}
