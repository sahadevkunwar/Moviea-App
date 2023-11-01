import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/data/repository/logout_repo_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_cubit.freezed.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._logoutRepoImpl) : super(const LogoutState.initial());

  final LogoutRepoImpl _logoutRepoImpl;

  void logoutUser() {
    emit(const LogoutState.processing());
    _logoutRepoImpl.logoutUser();
    emit(const LogoutState.success());
  }
}
