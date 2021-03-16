import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final Future<SharedPreferences> _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.auth_token);
    });
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.auth_token) ?? false;
    });
  }

  Future<bool> get isOnBoarding async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.is_onBoarding);
    });
  }

  Future<bool> get isSplash async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.is_splash);
    });
  }

  Future<bool> get isOnLine async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.is_onLine);
    });
  }

  Future<bool> get currentNavigation async {
    return _sharedPreference.then((preference) {
      preference.getString(Preferences.current_navigation);
    });
  }

  Future<void> saveCurrentNavigation(String currNav) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.current_navigation, currNav);
    });
  }

  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }
}
