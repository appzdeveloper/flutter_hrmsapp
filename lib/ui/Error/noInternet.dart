import 'dart:async';

import 'package:hrms/constants/strings.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:hrms/widgets/gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO : Add Connectivity State Handler for redirection of this page please ref : https://github.com/jogboms/flutter_offline
class NoInternetScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                'assets/images/noInternet.png',
                fit: BoxFit.cover,
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    Strings.noInternet_title,
                    style: TextStyle(
                        color: Color(0xFF1C1A1A),
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    Strings.noInternet_description,
                    style: TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              RaisedGradientButton(
                width: 140.0,
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF5574F7), Color(0xFF60C3FF)],
                ),
                child: const Text('RETRY',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: this.navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool(Preferences.is_logged_in) == true) {
      Navigator.of(context).pushReplacementNamed(Routes.dashboard);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
