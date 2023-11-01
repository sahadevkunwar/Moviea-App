import 'package:bloc_project/feature/auth/source/app_source.dart';

class AppRepoImpl {
  AppRepoImpl(this._appSource);
  final AppSource _appSource;

  bool checkIfUserIsLoggedInPreviouslY() {
    return _appSource.checkIfUserIsLoggedInPreviouslY();
  }
}
