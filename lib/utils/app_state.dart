import 'package:shared_preferences/shared_preferences.dart';

const String AppStateKey = "app_state";

class AppStateManger {
  static Future<void> setAppState(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStateKey, value);
  }

  static Future<String> getAppState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempAppState = prefs.getInt(AppStateKey);
    print('App State ------------------> $tempAppState');

    if (tempAppState == null) {
      return "0";
    } else {
      return tempAppState.toString();
    }
  }
}
