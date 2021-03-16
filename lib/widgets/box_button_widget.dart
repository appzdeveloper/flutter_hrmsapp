import 'package:flutter/material.dart';

class BoxButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const BoxButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding:  const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
      color: buttonColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button.copyWith(color: textColor),
      ),
    );
  }
}
