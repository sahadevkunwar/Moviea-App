import 'package:bloc/bloc.dart';
import 'package:bloc_project/feature/auth/data/models/registration_model.dart';
import 'package:bloc_project/feature/auth/data/register_repo_impl.dart';
import 'package:bloc_project/main.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'register_bloc.freezed.dart';

class AuthBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthBloc()
      : _registerRepoImpl = getIt<RegisterRepoImpl>(),
        super(RegisterState.initial()) {
    on<RegisterButtonClickEvent>(registerUser);
    on<LoginButtonClickEvent>(loginUser);
  }
  late final RegisterRepoImpl _registerRepoImpl;

  void registerUser(RegisterButtonClickEvent event, emit) {
    emit(RegisterState.registering());
    final bool isCredentialStored = _registerRepoImpl.storeRegistrationData(
        registrationModel: event.registrationModel);
    if (isCredentialStored) {
      emit(RegisterState.success(message: 'Register Success'));
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
    _registerRepoImpl.loginUser(
        username: event.username, password: event.password);

    print("here");
    emit(RegisteringState());
  }
}
