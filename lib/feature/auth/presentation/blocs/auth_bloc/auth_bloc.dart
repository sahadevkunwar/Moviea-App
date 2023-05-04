import 'package:bloc/bloc.dart';
import 'package:bloc_project/feature/auth/data/models/registration_model.dart';
import 'package:bloc_project/feature/auth/data/register_repo_impl.dart';
import 'package:bloc_project/main.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : _registerRepoImpl = getIt<RegisterRepoImpl>(),
        super(AuthState.initial()) {
    on<RegisterButtonClickEvent>(registerUser);
    on<LoginButtonClickEvent>(loginUser);
  }
  late final RegisterRepoImpl _registerRepoImpl;

  void registerUser(RegisterButtonClickEvent event, emit) {
    emit(AuthState.registering());
    final bool isCredentialStored = _registerRepoImpl.storeRegistrationData(
        registrationModel: event.registrationModel);
    if (isCredentialStored) {
      emit(AuthState.success(message: 'Register Success'));
    }
  }

  // FutureOr<void> loginUser(
  //     LoginButtonClickEvent event, Emitter<RegisterState> emit) {
  //   _registerRepoImpl.loginUser(
  //       username: event.username, password: event.password);
  //   //print('here');
  //   emit(RegisteringState());
  // }
  void loginUser(LoginButtonClickEvent event, emit) {
    emit(AuthState.logging());
    final bool isValidUser = _registerRepoImpl.loginUser(
        username: event.username, password: event.password);
    if (isValidUser) {
      emit(AuthState.loginSuccess(message: 'Login Success'));
    } else {
      emit(AuthState.authError(message: 'Invalid login credential'));
    }
  }
}
