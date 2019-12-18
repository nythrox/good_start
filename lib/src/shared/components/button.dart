
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color color;
  final Color highlightColor;
  final Color splashColor;

  final Color borderColor;
  final Color highlightBorderColor;

  final double width;
  final double borderWidth;
  final Widget child;
  final Function onPressed;
  final double borderRadius;
  const Button(
      {Key key,
      this.color,
      @required this.onPressed,
      this.child,
      this.width,
      this.borderRadius = 0,
      this.borderColor,
      this.borderWidth = 2,
      this.highlightColor,
      this.splashColor,
      this.highlightBorderColor,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (borderColor != null && color == null) {
      //only border color
      return SizedBox(
        width: width,
        child: OutlineButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: onPressed,
          child: child,
          splashColor: splashColor,
          highlightColor: highlightColor,
          highlightedBorderColor: highlightBorderColor,
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      );
    } else if (color != null &&
        borderColor != null) //background color and border color
      return Container(
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30)),
        child: OutlineButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: onPressed,
          child: child,
          splashColor: splashColor,
          highlightColor: highlightColor,
          highlightedBorderColor: highlightBorderColor,
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
      );
    else if (color != null && borderColor == null) //only background color
      return SizedBox(
        width: width,
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: onPressed,
          color: color,
          child: child,
          highlightColor: highlightColor,
          splashColor: splashColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        ),
      );
    else //no background color no border color
      return SizedBox(
        width: width,
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 14),
          onPressed: onPressed,
          child: child,
          highlightColor: highlightColor,
          splashColor: splashColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
        ),
      );
  }
}
