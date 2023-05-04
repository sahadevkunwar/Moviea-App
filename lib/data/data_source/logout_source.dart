import 'package:bloc_project/core/utils/hive_storage.dart';

class LogoutDataSource {
  LogoutDataSource(this._hiveUtils);
  final HiveUtils _hiveUtils;
  void logoutUser() {
    _hiveUtils.logoutUser();
  }
}
