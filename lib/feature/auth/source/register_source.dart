import 'package:bloc_project/core/utils/hive_storage.dart';
import 'package:bloc_project/feature/auth/data/models/registration_model.dart';

class RegisterSource {
  RegisterSource(this._hiveUtils);
  final HiveUtils _hiveUtils;

  bool registerUser({required RegistrationModel registrationModel}) {
    return _hiveUtils.registerUser(registrationModel);
  }

  bool checkCredential({required String username, required String password}) {
    final registeredUserJson = Map<String, dynamic>.from(
        _hiveUtils.getRegisterUser(username: username));
    final RegistrationModel registrationModel =
        RegistrationModel.fromJson(registeredUserJson);
    final String? hiveUsername = registrationModel.username;
    final String? hivePassword = registrationModel.password;

    final isValidCredential =
        (username == hiveUsername && password == hivePassword);
    if (isValidCredential) {
      _hiveUtils.saveLoggedInState(status: true);
    } else {
      _hiveUtils.saveLoggedInState(status: false);
    }
    return isValidCredential;
  }
}
