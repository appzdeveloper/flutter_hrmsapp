import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String label;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextAlign textAlignment;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final bool autoFocus;
  final TextInputAction inputAction;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.label,
    this.hint,
    this.textAlignment,
    this.errorText,
    this.isObscure = false,
    this.inputType,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.white70,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        textAlign: this.textAlignment,
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: 25,
        keyboardType: this.inputType,
        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        decoration: InputDecoration(
          labelText: this.label,
          labelStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          hintText: this.hint,
          hintStyle: Theme.of(context)
              .textTheme
              .body1
              .copyWith(color: hintColor, fontSize: 16.0),
          errorText: errorText,
          counterText: '',
        ),
      ),
    );
  }
}
