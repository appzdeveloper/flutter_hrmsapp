import 'dart:async';

import 'package:hrms/constants/app_theme.dart';
import 'package:hrms/constants/strings.dart';
import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/stores/messages/messages_store.dart';
import 'package:hrms/ui/navigation_drawer/navigation_drawer.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:hrms/widgets/card_widget.dart';
import 'package:hrms/widgets/gradient_button.dart';
import 'package:hrms/widgets/progress_indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InboxScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  MessageModel msgList;
  final _store = MessagesStore();
  @override
  void initState() {
    super.initState();

    //get inbox messages
    _store.getMessages().then((data) => {
          setState(() {
            this.msgList = _store.messagesList;
            // this.msgList = data;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    AppBar _appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
          padding: EdgeInsets.only(left: 20.0),
          icon: const Icon(Icons.add),
          iconSize: 30.0,
          color: Colors.black,
          onPressed: () => {}),
      centerTitle: true,
      title: Text(
        Strings.inbox_page_title,
        style: TextStyle(color: Color(0xFF5887F9)),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: 30.0),
          icon: const Icon(CustomIcons.custom_menu),
          iconSize: 18.0,
          color: Colors.black,
          onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
        ),
      ],
    );
    _inboxListItems(Data _model) {
      return null;
    }

    Widget _inboxList = Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8ED),
          ),
        ),
      ),
      child: this.msgList != null
          ? ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: this.msgList.data.length,
              itemBuilder: (context, index) {
                Data _model = this.msgList.data[index];
                return InkWell(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      Routes.chat,
                    )
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFE2E8ED),
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                _model.sentTime,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 11.0, color: Color(0xFFBCC5D3)),
                              ),
                            ),
                          ],
                        ),
                        Row(children: <Widget>[
                          //TODO: Make Color of Dot Dynamic for Future Use
                          Icon(
                            Icons.brightness_1,
                            color: _model.isOnline == true
                                ? Color(0xFF60C3FF)
                                : Color(0xFFE2E8ED),
                            size: 15.0,
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(_model.avatarURL),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _model.username,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFF4C5264),
                                      fontWeight: _model.isRead == false
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  _model.messageBody,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xFF4C5264),
                                      fontWeight: _model.isRead == false
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              },
            )
          : Align(
              alignment: Alignment.center,
              child: Text(
                'No data found',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 15.0,
                    color: Colors.grey),
              ),
            ),
    );

    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: new AppDrawer(),
        appBar: _appBar,
        body: Container(
          child: _store.loading ? CustomProgressIndicatorWidget() : _inboxList,
        ),
      ),
    );
  }
}
