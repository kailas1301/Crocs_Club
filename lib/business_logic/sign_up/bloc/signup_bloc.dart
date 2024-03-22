import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/models/signup_model.dart';
import 'package:crocs_club/data/repositories/auth/authrepo.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    final AuthRepository authRepository = AuthRepository();
    on<SignupButtonPressed>((event, emit) async {
      emit(SignUpLoading());
      try {
        if (event.password != event.confirmPassword) {
          emit(SignUpFormInvalid(error: 'Passwords do not match'));
        }

        final signupRequest = SignUpRequest(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        final response = await authRepository.signup(signupRequest);
        if (response == 'success') {
          emit(SignUpSuccessful('User signed up successfully'));
        } else {
          emit(SignUpError(response));
        }
      } catch (e) {
        emit(SignUpError(e.toString()));
      }
    });
  }
}
