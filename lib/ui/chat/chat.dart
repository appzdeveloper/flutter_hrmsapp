import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hrms/constants/app_theme.dart';
import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/models/Messages/Messages.dart';
import 'package:hrms/models/chatModel.dart';
import 'package:hrms/models/chatModel.dart';
import 'package:hrms/stores/global/global_store.dart';
import 'package:hrms/ui/navigation_drawer/navigation_drawer.dart';
import 'package:hrms/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:hrms/widgets/chat_bubble.dart';

import '../../routes.dart';
import 'full_photo_view.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _store = GlobalStore();
  ScrollController _scrollController = new ScrollController();
  TextEditingController _textEditingController = new TextEditingController();

  Global global = new Global();
  ChatModel messageList;
  @override
  void initState() {
    super.initState();
    _store.getConversation().then((data) {
      setState(() {
        this.messageList = _store.chatData;
        print(this.messageList);
      });
      print(data);
    }).catchError((err) {
      print(err);
      setState(() {
        this.messageList = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final avatar = "https://randomuser.me/api/portraits/women/85.jpg";
    final name = 'Lucy Lee';
    if (messageList.data.length > 0 && messageList != null) {
      Timer(
          Duration(milliseconds: 1000),
          () => _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent));
    }
    AppBar _appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      centerTitle: true,
      titleSpacing: 0.0,
      title: InkWell(
        onTap: () => {
          Navigator.pushNamed(
            context,
            Routes.profile,
          )
        },
        child: Container(
          height: 40.0,
          width: 40.0,
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(avatar),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            name,
            style: TextStyle(color: Color(0xFF5887F9)),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: 30.0),
          icon: const Icon(CustomIcons.menu),
          iconSize: 30.0,
          color: Colors.black,
          onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
        ),
      ],
    );
    _inboxListItems(ChatData _model) {
      return null;
    }

    insertMessage(List<File> selectedFile) {}

    onSendMessage(text) {
      var newLastMessage = ChatData(
        type: 0,
        avatarURL: "https://randomuser.me/api/portraits/women/85.jpg",
        body: text,
        fromUserId: 0,
        fromUserName: '',
        time: 'Nov 7, 09:21',
      );

      messageList.data.add(newLastMessage);
      _textEditingController.clear();
    }

    Widget _inboxList = Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E8ED),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE2E8ED),
            ),
          ),
        ),
        child: messageList != null && messageList.data.length > 0
            ? ListView.builder(
                itemCount: messageList.data.length,
                controller: _scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                itemBuilder: (context, index) {
                  ChatData msg = messageList.data[index];
                  bool isMe = msg.fromUserId == 0 ? true : false;
                  return Column(
                    children: <Widget>[
                      (msg.type == 0
                          ? ChatBubble(
                              isMe: isMe,
                              padding: ChatBubbleEdges.all(20.0),
                              isLabel: false,
                              margin: isMe
                                  ? ChatBubbleEdges.only(left: 40.0)
                                  : ChatBubbleEdges.only(right: 40.0),
                              alignment:
                                  isMe ? Alignment.topRight : Alignment.topLeft,
                              indi: isMe
                                  ? ChatBubbleIndi.rightTop
                                  : ChatBubbleIndi.leftTop,
                              child: Text(
                                msg.body,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color:
                                        isMe ? Color(0xFF707070) : Colors.white,
                                    fontSize: 14.0),
                              ),
                            )
                          : Container(
                              alignment:
                                  isMe ? Alignment.topRight : Alignment.topLeft,
                              child: FlatButton(
                                child: Material(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      padding: EdgeInsets.all(50.0),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                themeData.primaryColor),
                                      ),
                                      width: 200.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Material(
                                      child: Image.asset(
                                        'images/img_not_available.jpeg',
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    imageUrl: msg.avatarURL,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FullPhoto(url: msg.avatarURL)));
                                },
                                padding: EdgeInsets.all(0),
                              ),
                              margin:
                                  EdgeInsets.only(bottom: 10.0, right: 10.0),
                            )),
                      Align(
                        alignment:
                            isMe ? Alignment.bottomRight : Alignment.bottomLeft,
                        child: Text(
                          msg.time,
                          textAlign: isMe ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF707070), fontSize: 13.0),
                        ),
                      ),
                    ],
                  );
                })
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
      ),
    );

    return Material(
      child: Scaffold(
        endDrawer: AppDrawer(),
        appBar: _appBar,
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(child: _inboxList),
              Divider(height: 1.0),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: Color(0xFF1C1A1A),
                          ),
                          onPressed: () {
                            List<File> selectedFiles = global.openFilePicker();
                            //TODO: send selected files and update conversation
                            insertMessage(selectedFiles);
                          }),
                    ),
                    Flexible(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: "Write your message...",
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                          icon: Icon(
                            CustomIcons.send,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (_textEditingController.text != '') {
                              setState(() {
                                onSendMessage(_textEditingController.text);
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return null;
}
