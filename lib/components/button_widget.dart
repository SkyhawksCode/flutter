import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final GestureTapCallback onPressed;
  final EdgeInsets padding;

  const ButtonWidget(
      {Key key,
      @required this.buttonName,
      this.buttonColor,
      this.textColor,
      this.borderColor,
      @required this.onPressed,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor == null ? Color(0xFFfb6651) : buttonColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 2,
            color: borderColor == null ? Color(0xFFfb6651) : borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding == null ? const EdgeInsets.all(16.0) : padding,
        child: Text(
          '$buttonName',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              color: textColor == null ? Colors.white : textColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
