import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static late SharedPreferences sharedPreferences;
  SharedPreferenceServices._();

  static Future<SharedPreferenceServices> create() async {
    SharedPreferenceServices pref = SharedPreferenceServices._();
    await pref.init();
    return pref;
  }

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('firstRun')) {
      sharedPreferences.setBool('firstRun', true);
    }
  }

  bool? isFirstRun() {
    return sharedPreferences.getBool('firstRun');
  }
}
