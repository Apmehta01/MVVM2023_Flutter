import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mydemomvvm/utils/Constants.dart';

class UiUtils {
  static toastSuccessMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  static toastErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  static void flushBarSuccess(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          duration: Duration(seconds: int.parse(Constants.FLUSH_TIME_OUT)),
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.green,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.ac_unit_sharp,
            size: 28,
            color: Colors.white,
          ),
        )..show(context));
  }

  static void flushBarError(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          duration: Duration(seconds: int.parse(Constants.FLUSH_TIME_OUT)),
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}
