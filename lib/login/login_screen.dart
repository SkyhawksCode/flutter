import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trade_inn/components/button_widget.dart';
import 'package:trade_inn/components/error_widget.dart';
import 'package:trade_inn/home/home_screen.dart';
import 'package:trade_inn/localization/language/languages.dart';
import 'package:trade_inn/localization/locale_constant.dart';
import 'package:trade_inn/model/language_data.dart';
import 'package:trade_inn/utility/utils.dart';

import 'login_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///Object for Store
  final _store = LoginStore();

  ///TextEditing controller
  TextEditingController _controllerName, _controllerPassword;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    //Initialise controllers
    _controllerName = TextEditingController();
    _controllerPassword = TextEditingController();
    _store.moveToHome = _gotToHome;
    super.initState();
  }
  _gotToHome() {
    Utils.moveToNextAndRemove(
        HomeScreen(
          userName: _controllerName.text,
        ),
        context);
  }
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Observer(
          builder: (_) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// For logo
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Image.asset(
                                  'assets/logo.jpeg',
                                  height: 80,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  _createLanguageDropDown()
                                ],
                              ),
                            ),
                            //For sign in Text
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                Languages.of(context).labelSignIn,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                            // For User name
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, right: 16, left: 16),
                              child: Text(
                                Languages.of(context).labelUserName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),

                            ///Text field for user name
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, right: 16, left: 16),
                              child: TextField(
                                maxLines: 1,
                                controller: _controllerName,
                                textInputAction: TextInputAction.next,
                                decoration: new InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 16, bottom: 8),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    hintText: Languages.of(context).labelEnterUserName),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, right: 16, left: 16),
                              child: Text(
                                Languages.of(context).labelPassword,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),

                            ///Text field for user password
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, right: 16, left: 16),
                              child: Stack(
                                children: [
                                  TextField(
                                    controller: _controllerPassword,
                                    maxLines: 1,
                                    obscureText: _store.shouldObscurePassword,
                                    textInputAction: TextInputAction.done,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 16, right: 36, bottom: 8),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        hintText: Languages.of(context).labelEnterPassword),
                                  ),
                                  //For visibility icon
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: InkWell(
                                        onTap: () {
                                          _store.showPassword();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                              _store.shouldObscurePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///Button for Login
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ButtonWidget(
                                      buttonName: Languages.of(context).labelSignIn,
                                      onPressed: () {
                                        _store.doLogin(_controllerName.text,
                                            _controllerPassword.text);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            
                          ],
                        ),
                      ),
                      ErrorHandlerWidget(store: _store),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages.of(context).labelSelectLanguage),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
      )
          .toList(),
    );
  }

  ///this method is used to navigate on home page
  
}

