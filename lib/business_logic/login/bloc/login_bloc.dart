import 'package:bloc/bloc.dart';
import 'package:crocs_club/data/models/login_model.dart';
import 'package:crocs_club/data/repositories/auth/authrepo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final AuthRepository authRepository = AuthRepository();

    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final loginRequest = LoginRequest(
          email: event.email,
          password: event.password,
        );

        final response = await authRepository.login(loginRequest);
        if (response == 'success') {
          emit(LoginSuccessful('User signed up successfully'));
        } else {
          emit(LoginError(response));
        }
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
