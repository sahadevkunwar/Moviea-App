import 'package:bloc_project/data/data_source/logout_source.dart';

class LogoutRepoImpl {
  LogoutRepoImpl(this._logoutDataSource);
  late final LogoutDataSource _logoutDataSource;
  void logoutUser() {
    _logoutDataSource.logoutUser();
  }
}
