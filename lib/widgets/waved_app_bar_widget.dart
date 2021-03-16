import 'package:flutter/material.dart';

class WavedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const WavedAppBar({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage("assets/images/sound-wave.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(this.title),
    );
  }

  @override
  Size get preferredSize => Size(300.0, 300.0);
}
