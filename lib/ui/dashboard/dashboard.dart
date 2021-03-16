import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hrms/constants/strings.dart';
import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/models/dashboard_model.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/services/internetConnectivity.dart';
import 'package:hrms/stores/form/form_store.dart';
import 'package:hrms/stores/global/global_store.dart';
import 'package:hrms/ui/navigation_drawer/navigation_drawer.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:hrms/widgets/box_button_widget.dart';
import 'package:hrms/widgets/card_widget.dart';
import 'package:hrms/widgets/chart_widget.dart';
import 'package:hrms/widgets/empty_app_bar_widget.dart';
import 'package:hrms/widgets/gradient_button.dart';
import 'package:hrms/widgets/progress_indicator_widget.dart';
import 'package:hrms/widgets/rounded_button_widget.dart';
import 'package:hrms/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:hrms/widgets/waved_app_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flushbar/flushbar_helper.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
// TODO: Pull To refresh Ref: https://www.filledstacks.com/snippet/pull-to-refresh-in-flutter-with-background-image/

  StreamSubscription _streamSubscription;
  ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // global store
  final _store = GlobalStore();
  DashboardModel dashboardData;
  var connectionStatus;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
    //get dashboard data
    _store.getDashboard().then((data) {
      setState(() {
        this.dashboardData = _store.dashboardData;
        print(this.dashboardData);
      });
      print(data);
    }).catchError((err) {
      print(err);
      setState(() {
        this.dashboardData = null;
      });
    });
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > 200.0 - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    Container recentList = this.dashboardData != null
        ? Container(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount:
                  this.dashboardData.data.single.recentAnnouncements.length,
              itemBuilder: (context, index) {
                var _model =
                    this.dashboardData.data.single.recentAnnouncements[index];
                return CustomCardWidget(
                  isAvatar: true,
                  isIcons: false,
                  avatarURL: _model.avatarURL,
                  title: _model.username,
                  titleStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF353535),
                      fontWeight: FontWeight.bold),
                  body: _model.messageBody,
                  bodyStyle:
                      TextStyle(fontSize: 12.0, color: Color(0xFF777777)),
                  bottomText: _model.createdTime,
                  bottomTextStyle: TextStyle(fontSize: 9.0),
                );
              },
            ),
          )
        : Container();

    Container messageList = this.dashboardData != null
        ? Container(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: this.dashboardData.data.single.unreadMessages.length,
              itemBuilder: (context, index) {
                var _model =
                    this.dashboardData.data.single.unreadMessages[index];
                return CustomCardWidget(
                  isAvatar: true,
                  isIcons: true,
                  avatarURL: _model.avatarURL,
                  title: _model.fromUserName != ''
                      ? _model.fromUserName
                      : 'Unknown User',
                  titleStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF353535),
                      fontWeight: FontWeight.bold),
                  body: _model.body,
                  bodyStyle:
                      TextStyle(fontSize: 12.0, color: Color(0xFF777777)),
                  bottomText: _model.time,
                  bottomTextStyle: TextStyle(fontSize: 9.0),
                );
              },
            ),
          )
        : Container();

    _recentAnnouncements() {
      return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Recent Announcements',
              style: TextStyle(
                color: Color(0xFF1C1A1A),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            recentList
          ],
        ),
      );
    }

    _unReadMessages() {
      return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Unread Messages',
              style: TextStyle(
                color: Color(0xFF1C1A1A),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageList,
          ],
        ),
      );
    }

    _customAppBar() {
      return new AppBar();
    }

    _getChartTitle() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Text(
              'Monthly Pay Status',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF353535),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'This Month : ',
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFF0093E9),
                fontWeight: FontWeight.bold),
          ),
          Text(
            this.dashboardData.data.single.payStatus.toString() + '%',
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFE57373),
                fontWeight: FontWeight.bold),
          )
        ],
      );
    }

    _pageTitle() {
      return Center(
        child: _showTitle
            ? null
            : Text(
                Strings.dashboard_page_title,
                style: TextStyle(
                    color: Color(0xFF1C1A1A),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic),
              ),
      );
    }

    _clockButtons() {
      // TODO : make dynamic button based on status
      return Container(
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
            child: const Text('Clock In',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            onPressed: () => {},
          ),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: new AppDrawer(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: true,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(right: 30.0),
                  icon: const Icon(CustomIcons.custom_menu),
                  iconSize: 20.0,
                  color: Colors.white,
                  onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                ),
              ],
              title: _showTitle
                  ? Text(
                      'Dashboard',
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Good Morning,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          Text(
                            'Carol Danvers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
              titleSpacing: 10.0,
              leading: _showTitle
                  ? null
                  : Icon(
                      Icons.wb_sunny,
                      color: Colors.white,
                    ),
              expandedHeight: 240.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFF5574F7), Color(0xFF60C3FF)],
                  ),
                ),
                child: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  background: new Container(
                    alignment: Alignment.topCenter,
                    height: double.maxFinite,
                    width: double.infinity,
                    decoration: _showTitle
                        ? null
                        : new BoxDecoration(
                            color: Colors.white,
                            image: new DecorationImage(
                              alignment: Alignment.topCenter,
                              image: new AssetImage(
                                  "assets/images/sound-wave.png"),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: _store.loading
            ? CustomProgressIndicatorWidget()
            : Container(
                margin: EdgeInsets.only(top: _showTitle ? 80.0 : 20.0),
                color: Colors.transparent,
                child: this.dashboardData != null
                    ? SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 130.0),
                        child: Column(
                          children: <Widget>[
                            _pageTitle(),
                            _getChartTitle(),
                            LineChartSample3(),
                            _recentAnnouncements(),
                            _unReadMessages(),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Data Found',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
              ),
      ),
      bottomSheet: _clockButtons(),
    );
  }
}
