import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:trade_inn/base/base_store.dart';
import 'package:trade_inn/localization/language/languages.dart';
import 'package:trade_inn/utility/constants.dart';
import 'package:trade_inn/utility/shared_preference_utils.dart';
import 'package:http/http.dart' as http;
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore extends BaseStore with Store {
  ///Observe to show password
  @observable
  bool shouldObscurePassword = true;
  final firestoreInstance = FirebaseFirestore.instance;
  Function moveToHome;

  ///This action is used to show/hide password
  @action
  showPassword() {
    if (shouldObscurePassword)
      shouldObscurePassword = false;
    else
      shouldObscurePassword = true;
  }

  ///This action is used to validate and make an API call for once user
  ///click on sign in button
  Future<dynamic> sendData(user, pass) async {
    var body = {
      'email': user,
      'password': pass,
    };
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(
      'http://bsbdata.myqnapcloud.com/api/login', body: json.encode(body) , headers: headers 
    );
    //print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  
  @action
  doLogin(String userName, String password) async {
    
    if (userName.isEmpty) {
      isError = true;
      errorMessage = "Please Enter Username";
    } else if (password.isEmpty) {
      isError = true;
      errorMessage = "Please Enter password";
    } else {
      //now make api call
      shouldLoad = false;
      sendData(userName, password).then((response){
          if(response['success']){
            PreferenceUtils.setBool(Constants.IS_LOGGED_IN, true);
            PreferenceUtils.setString(Constants.USER_NAME, userName);
            if (moveToHome != null) {
              moveToHome();
            }
          }else{
            isError = true;
            errorMessage = "Please enter valid credentials";
          }
        }
      );
    }
  }

}
