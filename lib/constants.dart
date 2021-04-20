import 'package:flutter_web/cupertino.dart' show CupertinoColors;
import 'package:flutter_web/material.dart';

const kNavTitleTextStyle = TextStyle(
color: CupertinoColors.white,
fontSize: 18.5,
fontWeight: FontWeight.bold
);

const kTextStyle = TextStyle(
  color: CupertinoColors.white,
  fontSize: 80,
  fontFamily: 'HelveticaUltraLight',
);

const kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'Helvetica',
);

const kErrorTextStyle = TextStyle(
    color: CupertinoColors.destructiveRed,
    fontSize: 13,
    fontFamily: 'HelveticaLight');

const kTextFieldStyle = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(28.0)),
  ),
);

class CurrentTime {
  final int milliseconds;
  final int seconds;
  final int minutes;

  CurrentTime({this.milliseconds, this.seconds, this.minutes});
}
