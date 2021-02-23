
import 'package:trade_inn/utility/end_points.dart';

import 'api_methods.dart';

//This class is responsible to send required parameters to make API call and
// return back result to bloc
class Repository {
  Repository._privateConstructor();

  static final Repository _repository = Repository._privateConstructor();

  factory Repository() {
    return _repository;
  }

  //Object for APi methods class
  ApiMethods _apiProvider = ApiMethods();

  /*
  This method is called when user request for login
   */
  Future<dynamic> makeLoginRequest(String body) =>
      _apiProvider.requestInPost(EndPoints.LOGIN_URL, null, body);

}
