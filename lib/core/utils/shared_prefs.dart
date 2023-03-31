import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils{
static SharedPreferences? _prefsInstance;

static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();

//call this method from initState() of mainApp()
static void init()async{
  _prefsInstance=await _instance;

}
static String getString(String key,[String? defValue]){
 return _prefsInstance?.getString(key) ?? defValue ?? "Def Value";
}
static Future<bool> setString (String key , String value)async{
  return _prefsInstance?.setString(key, value) ?? Future.value(false);
}


}

///Metaphor to understand PreferenceUtils class
class Apple{
  static int? a;

  static int get _getMyApple =>a ??=2;

  int? init(){
    a=_getMyApple;
    return a;
  }
}