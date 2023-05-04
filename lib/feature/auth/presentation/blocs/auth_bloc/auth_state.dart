part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.initial() = InitialState;
  factory AuthState.success({required String message}) = RegisterSuccessState;
  factory AuthState.loginSuccess({required String message}) = LoginSuccessState;
  factory AuthState.authError({required String message}) = ErrorState;
  factory AuthState.registering() = RegisteringState;
  factory AuthState.logging() = LoggingState;
}

// class RegisterInitial extends RegisterState {
//   @override
//   List<Object> get props => [];
// }
// class RegisteringState extends RegisterState {
//   @override
//   List<Object> get props => [];
// }
// class RegisterSuccessState extends RegisterState {
//   const RegisterSuccessState();
//   //final String message;
//
//   @override
//   List<Object> get props => [];
// }
