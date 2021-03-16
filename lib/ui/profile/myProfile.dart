import 'dart:async';

import 'package:hrms/constants/app_theme.dart';
import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/ui/navigation_drawer/navigation_drawer.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:hrms/widgets/gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: new AppDrawer(),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 30.0),
              icon: const Icon(CustomIcons.custom_menu),
              iconSize: 18.0,
              color: Colors.black,
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: themeData.primaryColor,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/85.jpg",
                      scale: 36.0),
                ),
              ),
              Text(
                'Bharat Nadela',
                style: TextStyle(
                    color: Color(0xFF1A1C1C),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Employee, Jamkubha LLC',
                style: TextStyle(
                  color: Color(0xFF1A1C1C),
                  fontSize: 13.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            '23',
                            style: TextStyle(
                              color: Color(0xFF1A1C1C),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            'Absances this week',
                            style: TextStyle(
                              color: Color(0xFF1A1C1C),
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "\$500",
                            style: TextStyle(
                              color: Color(0xFF1A1C1C),
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            'Absances this week',
                            style: TextStyle(
                              color: Color(0xFF1A1C1C),
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color(0xFF707070).withOpacity(0.3),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Short Bio',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFF4C5264),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              new Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 130.0),
                  child: Text(
                    'Hello, my name’s Lucy Lee. I’m a photographer from New York, and have been in the industry for over 6 years. I specialise in landscape photography, and am passionate about sharing everything that I’ve learned on my photographic journey over the last 6 years. Ultimately, my goal is to help teach you everything about photography and to develop your skills from an absolute beginner, to professional photographer. Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line. Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring. Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.',
                    style: TextStyle(color: Color(0xFF4C5264), fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        //TODO : Hide Message Button on own Profile View
        bottomSheet: Container(
          padding: EdgeInsets.all(30.0),
          height: 180.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: <Color>[Colors.white.withOpacity(0.1), Colors.white],
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.transparent,
            child: RaisedGradientButton(
              width: 140.0,
              gradient: LinearGradient(
                colors: <Color>[Color(0xFF5574F7), Color(0xFF60C3FF)],
              ),
              child: const Text('MESSAGE',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onPressed: () => {},
            ),
          ),
        ),
      ),
    );
  }
}
