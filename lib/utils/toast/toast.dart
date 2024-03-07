import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String msg,
  Color? textColor,
  Color? backgroundColor,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
