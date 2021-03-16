import 'dart:async';

import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  String getCurrentRouteName(context) {
    String currentRouteName;

    Navigator.popUntil(context, (route) {
      currentRouteName = route.settings.name;
      return true;
    });

    return currentRouteName;
  }

  @override
  Widget build(BuildContext context) {
    String currentRoute = getCurrentRouteName(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            selected: currentRoute == Routes.dashboard,
            icon: CustomIcons.dashboard,
            text: 'Dashboard',
            onTap: () => {
              if (currentRoute == Routes.dashboard)
                {Navigator.pop(context)}
              else
                {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Routes.dashboard))
                }
            },
          ),
          _createDrawerItem(
            selected: currentRoute == Routes.inbox,
            icon: Icons.inbox,
            text: 'Inbox',
            onTap: () => {
              if (currentRoute == Routes.inbox)
                {Navigator.pop(context)}
              else
                {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.inbox,
                  )
                }
            },
          ),
          _createDrawerItem(
            selected: false,
            icon: Icons.mail,
            text: 'Leave Request',
            onTap: () => {Navigator.pop(context)},
          ),
          _createDrawerItem(
            selected: currentRoute == Routes.profile,
            icon: Icons.person,
            text: 'My Profile',
            onTap: () => {
              if (currentRoute == Routes.profile)
                {Navigator.pop(context)}
              else
                {
                  Navigator.popAndPushNamed(
                    context,
                    Routes.profile,
                  )
                }
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _createBottomTabs(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFF5574F7), Color(0xFF60C3FF)],
          ),
          // image: DecorationImage(
          //   fit: BoxFit.fill,
          //   image: AssetImage("assets/images/sound-wave.png"),
          // ),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("HRMS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap, bool selected}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      selected: selected,
      onTap: onTap,
    );
  }

  Widget _createBottomTabs(context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF707070).withOpacity(0.3),
          ),
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 20.0,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: Color(0xFF777777), fontSize: 9.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.info_outline,
                    size: 20.0,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  Text(
                    "About",
                    style: TextStyle(color: Color(0xFF777777), fontSize: 9.0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {
                SharedPreferences.getInstance().then((preference) {
                  preference.setBool(Preferences.is_logged_in, false);
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.login,
                  );
                })
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.power_settings_new,
                    size: 20.0,
                    color: Color(0xFF000000).withOpacity(0.5),
                  ),
                  Text(
                    "Logoff",
                    style: TextStyle(color: Color(0xFF777777), fontSize: 9.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
