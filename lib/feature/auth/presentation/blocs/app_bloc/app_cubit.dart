import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/feature/auth/data/app_repo_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._appRepoImpl) : super(const AppState.initial());

  final AppRepoImpl _appRepoImpl;
  void checkIfUserIsLoggedInPreviouslY() async {
    final userHaveLoggedInPreviously =
        _appRepoImpl.checkIfUserIsLoggedInPreviouslY();
    await Future.delayed(const Duration(seconds: 1));
    if (userHaveLoggedInPreviously) {
      emit(const AppState.isLoggedIn());
    } else {
      emit(const AppState.isNotLoggedIn());
    }
  }
}
