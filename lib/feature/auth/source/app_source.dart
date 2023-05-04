import 'package:bloc_project/core/utils/hive_storage.dart';

class AppSource {
  AppSource(this._hiveUtils);
  HiveUtils _hiveUtils;

  bool checkIfUserIsLoggedInPreviouslY() {
    return _hiveUtils.getLoggedInStatus();
  }
}
