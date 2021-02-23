import 'package:flutter/material.dart';

abstract class Languages {

  
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelUserName;

  String get labelPassword;

  String get labelEnterUserName;

  String get labelEnterPassword;

  String get labelSelectLanguage;

  String get labelSignIn;

  String get labelLogOut;

  String get labelLogindAs;

  String get labelCancel;

  String get labelMessage;

  String get errorMessage;

}
