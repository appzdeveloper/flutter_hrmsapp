import 'package:flutter/material.dart';
import 'package:hrms/constants/app_theme.dart';
import 'package:hrms/customIcons/custom_icons_icons.dart';
import 'package:hrms/models/Messages/Messages.dart';

import '../routes.dart';

class CustomCardWidget extends StatelessWidget {
  final Object data;
  final bool isAvatar;
  final bool isIcons;
  final String avatarURL;
  final String title;
  final TextStyle titleStyle;
  final String body;
  final TextStyle bodyStyle;
  final String bottomText;
  final TextStyle bottomTextStyle;
  final Column icons;
  final Function onTap;

  const CustomCardWidget(
      {Key key,
      this.data,
      this.isAvatar,
      this.avatarURL,
      this.isIcons,
      this.title,
      this.bodyStyle,
      this.body,
      this.bottomText,
      this.bottomTextStyle,
      this.icons,
      this.onTap,
      this.titleStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * 0.20);
    } else {
      imageSize = (size.height * 0.20);
    }
    _getText() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
              color: Color(0xFF707070).withOpacity(0.27), width: 1.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              color: Color(0xFF000000).withOpacity(0.10),
              offset: new Offset(0.0, 5.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              isThreeLine: false,
              leading: isAvatar
                  ? new Container(
                      child: CircleAvatar(
                        radius: 24.0,
                        backgroundColor: themeData.primaryColor,
                        backgroundImage: NetworkImage(avatarURL, scale: 36.0),
                      ),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.16),
                            offset: new Offset(0.0, 6.0),
                            blurRadius: 5.0,
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                    )
                  : Center(
                      child: Text(
                        'FN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              title: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      body,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: bodyStyle,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                bottomText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: bottomTextStyle,
              ),
            ),
          ],
        ),
      );
    }

    _getFirstRowPart() {
      return Expanded(
        flex: 3,
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                dense: true,
                isThreeLine: false,
                leading: isAvatar
                    ? new Container(
                        child: CircleAvatar(
                          radius: 24.0,
                          backgroundColor: themeData.primaryColor,
                          backgroundImage: NetworkImage(avatarURL, scale: 36.0),
                        ),
                        decoration: new BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.16),
                              offset: new Offset(0.0, 6.0),
                              blurRadius: 5.0,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                      )
                    : Center(
                        child: Text(
                          'FN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: 5.0,
                        width: double.infinity,
                      ),
                      Text(
                        body,
                        textWidthBasis: TextWidthBasis.parent,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: bodyStyle,
                      ),
                      SizedBox(
                        height: 5.0,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  bottomText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: bottomTextStyle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    _getFirsIcon() {
      return new SizedBox(
        width: 60.0,
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () => {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.replay,
                size: 20.0,
                color: Color(0xFF000000).withOpacity(0.5),
              ),
              Text(
                "Reply",
                style: TextStyle(color: Color(0xFF777777), fontSize: 9.0),
              ),
            ],
          ),
        ),
      );
    }

    _getSecondIcon() {
      return new SizedBox(
        width: 60.0,
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () => {
            Navigator.pushNamed(
              context,
              Routes.chat,
            )
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.remove_red_eye,
                size: 20.0,
                color: Color(0xFF000000).withOpacity(0.5),
              ),
              Text(
                "Read",
                style: TextStyle(color: Color(0xFF777777), fontSize: 9.0),
              ),
            ],
          ),
        ),
      );
    }

    _getTextWithIcons() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(
              color: Color(0xFF707070).withOpacity(0.27), width: 1.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              color: Color(0xFF000000).withOpacity(0.10),
              offset: new Offset(0.0, 5.0),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getFirstRowPart(),
            _getFirsIcon(),
            _getSecondIcon(),
          ],
        ),
      );
    }

    return isIcons ? _getTextWithIcons() : _getText();
  }
}
