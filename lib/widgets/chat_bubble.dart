import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

enum ChatBubbleIndi { no, leftTop, leftBottom, rightTop, rightBottom }

/// Class ChatBubbleEdges is an analog of EdgeInsets, but default values are null.
class ChatBubbleEdges {
  const ChatBubbleEdges.fromLTRB(this.left, this.top, this.right, this.bottom);

  const ChatBubbleEdges.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const ChatBubbleEdges.only({
    this.left, // = null
    this.top, // = null
    this.right, // = null
    this.bottom, // = null
  });

  const ChatBubbleEdges.symmetric({
    double vertical, // = null
    double horizontal, // = null
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  final double left;
  final double top;
  final double right;
  final double bottom;

  static get zero => ChatBubbleEdges.all(0);

  EdgeInsets get edgeInsets =>
      EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0);

  @override
  String toString() => 'ChatBubbleEdges($left, $top, $right, $bottom)';
}

class ChatBubbleStyle {
  const ChatBubbleStyle({
    this.radius,
    this.indi,
    this.indiWidth,
    this.indiHeight,
    this.indiOffset,
    this.indiRadius,
    this.stick,
    this.color,
    this.elevation,
    this.shadowColor,
    this.padding,
    this.margin,
    this.alignment,
  });

  final Radius radius;
  final ChatBubbleIndi indi;
  final double indiHeight;
  final double indiWidth;
  final double indiOffset;
  final double indiRadius;
  final bool stick;
  final Color color;
  final double elevation;
  final Color shadowColor;
  final ChatBubbleEdges padding;
  final ChatBubbleEdges margin;
  final Alignment alignment;
}

class ChatBubbleClipper extends CustomClipper<Path> {
  ChatBubbleClipper({
    this.radius,
    this.indi,
    this.indiWidth,
    this.indiHeight,
    this.indiOffset,
    this.indiRadius,
    this.stick,
    this.padding,
  })  : assert(indiWidth > 0.0),
        assert(indiHeight > 0.0),
        assert(indiRadius >= 0.0),
        assert(indiRadius <= indiWidth / 2.0 && indiRadius <= indiHeight / 2.0),
        assert(indiOffset >= 0.0),
//        assert(radius <= indiHeight + indiOffset),
        assert(padding != null),
        assert(padding.left != null),
        assert(padding.top != null),
        assert(padding.right != null),
        assert(padding.bottom != null),
        super() {
    _startOffset = _endOffset = indiWidth;

    var k = indiHeight / indiWidth;
    var a = atan(k);

    _indiCX = (indiRadius + sqrt(indiRadius * indiRadius * (1 + k * k))) / k;
    var indiStickOffset = (_indiCX - indiRadius).floorToDouble();

    _indiCX -= indiStickOffset;
    _indiCY = indiRadius;
    _indiPX = _indiCX - indiRadius * sin(a);
    _indiPY = _indiCY + indiRadius * cos(a);
    _startOffset -= indiStickOffset;
    _endOffset -= indiStickOffset;

    if (stick) _endOffset = 0.0;
  }

  final Radius radius;
  final ChatBubbleIndi indi;
  final double indiHeight;
  final double indiWidth;
  final double indiOffset;
  final double indiRadius;
  final bool stick;
  final bool isMe = true;
  final bool isLabel = false;
  final ChatBubbleEdges padding;

  double _startOffset; // Offsets of the bubble
  double _endOffset;
  double _indiCX; // The center of the circle
  double _indiCY;
  double _indiPX; // The point of contact of the indi with the circle
  double _indiPY;

  get edgeInsets {
    return indi == ChatBubbleIndi.leftTop || indi == ChatBubbleIndi.leftBottom
        ? EdgeInsets.only(
            left: _startOffset + padding.left,
            top: padding.top,
            right: _endOffset + padding.right,
            bottom: padding.bottom)
        : indi == ChatBubbleIndi.rightTop || indi == ChatBubbleIndi.rightBottom
            ? EdgeInsets.only(
                left: _endOffset + padding.left,
                top: padding.top,
                right: _startOffset + padding.right,
                bottom: padding.bottom)
            : EdgeInsets.only(
                left: _endOffset + padding.left,
                top: padding.top,
                right: _endOffset + padding.right,
                bottom: padding.bottom);
  }

  @override
  Path getClip(Size size) {
    var radiusX = radius.x;
    var radiusY = radius.y;
    var maxRadiusX = size.width / 2;
    var maxRadiusY = size.height / 2;

    if (radiusX > maxRadiusX) {
      radiusY *= maxRadiusX / radiusX;
      radiusX = maxRadiusX;
    }
    if (radiusY > maxRadiusY) {
      radiusX *= maxRadiusY / radiusY;
      radiusY = maxRadiusY;
    }

    var path = Path();

    switch (indi) {
      case ChatBubbleIndi.leftTop:
        //Draw Rectangle for chat message container
        path.addRRect(RRect.fromLTRBR(
            _startOffset, 0, size.width - _endOffset, size.height, radius));
        path.moveTo(
            size.width - _startOffset - radiusX, size.height - indiOffset);

        path.lineTo(_startOffset + radiusX, indiOffset + indiHeight);
        path.lineTo(_startOffset, indiOffset + indiHeight);
        if (indiRadius == 0) {
          path.lineTo(0, indiOffset);
        } else {
          path.lineTo(_indiPX, indiOffset + _indiPY);
          path.arcToPoint(Offset(_indiCX, indiOffset),
              radius: Radius.circular(indiRadius));
          path.lineTo(indiOffset + _indiPY, _indiPY);
        }
        path.close();
        break;

      case ChatBubbleIndi.leftBottom:
        path.addRRect(RRect.fromLTRBR(
            _startOffset, 0, size.width - _endOffset, size.height, radius));

        Path path2 = Path();
        path2.moveTo(_startOffset + radiusX, size.height - indiOffset);
        path2.lineTo(
            _startOffset + radiusX, size.height - indiOffset - indiHeight);
        path2.lineTo(_startOffset, size.height - indiOffset - indiHeight);
        if (indiRadius == 0) {
          path2.lineTo(0, size.height - indiOffset);
        } else {
          path2.lineTo(_indiPX, size.height - indiOffset - _indiPY);
          path2.arcToPoint(Offset(_indiCX, size.height - indiOffset),
              radius: Radius.circular(indiRadius), clockwise: false);
        }
        path2.close();

        path.addPath(path2, Offset(0, 0));
        path.addPath(path2, Offset(0, 0)); // Magic!
        break;

      case ChatBubbleIndi.rightTop:
        path.addRRect(RRect.fromLTRBR(
            _endOffset, 0, size.width - _startOffset, size.height, radius));

        Path path2 = Path();
        path2.moveTo(size.width - _startOffset - radiusX, indiOffset);
        path2.lineTo(
            size.width - _startOffset - radiusX, indiOffset + indiHeight);
        path2.lineTo(size.width - _startOffset, indiOffset + indiHeight);
        if (indiRadius == 0) {
          path2.lineTo(size.width, indiOffset);
        } else {
          path2.lineTo(size.width - _indiPX, indiOffset + _indiPY);
          path2.arcToPoint(Offset(size.width - _indiCX, indiOffset),
              radius: Radius.circular(indiRadius), clockwise: false);
        }
        path2.close();

        path.addPath(path2, Offset(0, 0));
        path.addPath(path2, Offset(0, 0)); // Magic!
        break;

      case ChatBubbleIndi.rightBottom:
        path.addRRect(RRect.fromLTRBR(
            _endOffset, 0, size.width - _startOffset, size.height, radius));
        path.moveTo(
            size.width - _startOffset - radiusX, size.height - indiOffset);
        path.lineTo(size.width - _startOffset - radiusX,
            size.height - indiOffset - indiHeight);
        path.lineTo(
            size.width - _startOffset, size.height - indiOffset - indiHeight);
        if (indiRadius == 0) {
          path.lineTo(size.width, size.height - indiOffset);
        } else {
          path.lineTo(size.width - _indiPX, size.height - indiOffset - _indiPY);
          path.arcToPoint(
              Offset(size.width - _indiCX, size.height - indiOffset),
              radius: Radius.circular(indiRadius));
        }
        path.close();
        break;

      case ChatBubbleIndi.no:
        path.addRRect(RRect.fromLTRBR(
            _endOffset, 0, size.width - _endOffset, size.height, radius));
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(ChatBubbleClipper oldClipper) => false;
}

class ChatBubble extends StatelessWidget {
  ChatBubble({
    this.child,
    bool isMe,
    bool isLabel,
    Radius radius,
    ChatBubbleIndi indi,
    double indiWidth,
    double indiHeight,
    double indiOffset = 20.0,
    double indiRadius,
    bool stick,
    Color color,
    double elevation,
    Color shadowColor,
    ChatBubbleEdges padding,
    ChatBubbleEdges margin,
    Alignment alignment,
    ChatBubbleStyle style,
  })  : color = color ?? style?.color ?? Colors.white,
        decoration = (isLabel
            ? null
            : (isMe
                ? BoxDecoration(
                    border: Border.all(color: Color(0xFFE2E8ED)),
                  )
                : BoxDecoration(
                    border: Border.all(color: Color(0xFFE2E8ED)),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF60C3FF),
                        Color(0xFF5574F7),
                      ],
                    ),
                  ))),
        elevation = elevation ?? style?.elevation ?? 1.0,
        shadowColor = shadowColor ?? style?.shadowColor ?? Colors.black,
        margin = ChatBubbleEdges.only(
          left: margin?.left ?? style?.margin?.left ?? 0.0,
          top: margin?.top ?? style?.margin?.top ?? 10.0,
          right: margin?.right ?? style?.margin?.right ?? 0.0,
          bottom: margin?.bottom ?? style?.margin?.bottom ?? 5.0,
        ),
        alignment = alignment ??
            style?.alignment ??
            (isLabel
                ? Alignment.center
                : (isMe ? Alignment.centerLeft : Alignment.centerRight)),
        bubbleClipper = ChatBubbleClipper(
          radius: radius ?? style?.radius ?? Radius.circular(6.0),
          indi: indi ?? style?.indi ?? ChatBubbleIndi.no,
          indiWidth: indiWidth ?? style?.indiWidth ?? 8.0,
          indiHeight: indiHeight ?? style?.indiHeight ?? 10.0,
          indiOffset: indiOffset ?? style?.indiOffset ?? 5.0,
          indiRadius: indiRadius ?? style?.indiRadius ?? 1.0,
          stick: stick ?? style?.stick ?? false,
          padding: ChatBubbleEdges.only(
            left: padding?.left ?? style?.padding?.left ?? 15.0,
            top: padding?.top ?? style?.padding?.top ?? 15.0,
            right: padding?.right ?? style?.padding?.right ?? 15.0,
            bottom: padding?.bottom ?? style?.padding?.bottom ?? 15.0,
          ),
        );

  final Widget child;
  final Color color;
  final double elevation;
  final Color shadowColor;
  final ChatBubbleEdges margin;
  final Alignment alignment;
  final ChatBubbleClipper bubbleClipper;
  final BoxDecoration decoration;

  Widget build(context) {
    return Container(
        alignment: alignment,
        margin: margin?.edgeInsets,
        child: PhysicalShape(
          clipBehavior: Clip.antiAlias,
          clipper: bubbleClipper,
          child: Container(
            decoration: decoration,
            padding: bubbleClipper.edgeInsets,
            child: child,
          ),
          color: color,
          elevation: elevation,
        ));
  }
}
