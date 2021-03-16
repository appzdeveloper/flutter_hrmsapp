import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectivityService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  // Create our public controller
  StreamController<bool> connectionStatusController = StreamController<bool>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t

      print("Connection Changed.....");
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  bool _getStatusFromResult(ConnectivityResult result) {
    SharedPreferences.getInstance().then((preference) {
      switch (result) {
        case ConnectivityResult.none:
          if (preference.getBool(Preferences.is_splash) == true &&
              preference.getBool(Preferences.is_onBoarding) == true) {
            navigatorKey.currentState.pushReplacementNamed(Routes.noInternet);
          }
          return false;

        default:
          if (preference.getBool(Preferences.is_splash) == true &&
              preference.getBool(Preferences.is_onBoarding) == true) {
            if (preference.getBool(Preferences.is_logged_in) == true) {
              navigatorKey.currentState.pushNamedAndRemoveUntil(
                  Routes.dashboard, (Route<dynamic> route) => false);
            } else {
              navigatorKey.currentState.pushNamedAndRemoveUntil(
                  Routes.login, (Route<dynamic> route) => false);
            }
          }
          return true;
      }
    });
  }

  bool isValid() {}
}
