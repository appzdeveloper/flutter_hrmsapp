import 'package:flutter/material.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: CircularProgressIndicator(),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        decoration: BoxDecoration(color: Colors.transparent),
      ),
    );
  }
}
