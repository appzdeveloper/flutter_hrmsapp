import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:hrms/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrms/services/internetConnectivity.dart';
import 'package:hrms/ui/Error/noInternet.dart';
import 'package:inject/inject.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'di/components/app_component.dart';
import 'di/modules/local_module.dart';
import 'di/modules/netwok_module.dart';
import 'ui/splash/splash.dart';

// global instance for app component
var appComponent;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    appComponent = await AppComponent.create(NetworkModule(), LocalModule());
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // statusBarColor: Color(0xFF5574F7),
        statusBarColor: Colors.white,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: themeData,
        routes: Routes.routes,
        navigatorKey: ConnectivityService().navigatorKey,
        home: new SplashScreen(),
      ),
    );
  }
}
