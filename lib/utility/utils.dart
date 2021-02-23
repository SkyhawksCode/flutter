import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trade_inn/components/button_widget.dart';
import 'colors.dart';

class Utils {
  //This method is used to show snack bar
  static showSnackBar(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.colorRed,
      duration: Duration(seconds: 2),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static hideSnackBar(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }

  //This method is used to move on next screen
  static moveToNext(Widget widget, BuildContext context) {
    Navigator.push(
        context, PageTransition(child: widget, type: PageTransitionType.fade));
  }

  //This method is used to move on next screen
  static moveToNextAndRemove(Widget widget, BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(child: widget, type: PageTransitionType.fade),
        (Route<dynamic> route) => false);
  }

  ///this method is used to check internet connection
  static Future<bool> isConnectionAvailable() async {
    try {
      await InternetAddress.lookup('google.com');
      return true;
    } on SocketException catch (_) {
      print('no connection');
      return false;
    }
  }

  ///This method is used to down the keyboard
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ///This method is using to show alert
  static Future<bool> showConfirmationAlert(BuildContext context,
      {String title,
      @required String text,
      GestureTapCallback callbackOKay,
      GestureTapCallback callbackCancel,
      String cancelButtonText,
      String okayButtonText}) {
    return showDialog(
            context: context,
            builder: (context) => Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 8.0),
                                child: Text(
                                  "$title",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonWidget(
                                            textColor: Colors.white,
                                            buttonName: '$cancelButtonText',
                                            buttonColor: AppColors.colorBlue,
                                            borderColor: AppColors.colorBlue,
                                            onPressed: callbackCancel),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonWidget(
                                            buttonName: '$okayButtonText',
                                            buttonColor: AppColors.colorRed,
                                            borderColor: AppColors.colorRed,
                                            onPressed: callbackOKay),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )) ??
        false;
  }

  //Validation for email
  static bool isValidEmail(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }
}
