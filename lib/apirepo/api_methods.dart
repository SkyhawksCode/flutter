import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trade_inn/model/error_model.dart';

///This class has API calling methods
///
class ApiMethods {
  ///This method handles request in GET
  Future<dynamic> requestInGet(String url, String token) async {
    print('Urls is $url');
    var responseJson;
    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": token != null ? "Bearer " + token : null
      }).timeout(Duration(seconds: 20));
      print(response.body);
      print('Response Code is  ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException catch (error) {
      print('Socket Exception');
      SocketException socketException = error;
      var map = '{"msg":  "${socketException.message.toString()}"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    } on TimeoutException catch (_) {
      print('Timeout Exception');
      var map = '{"msg": "Timeout"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    } catch (error) {
      print('Format Exception $error');
      FormatException formatException = error;
      var map = '{"msg": "${formatException.message.toString()}"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    }
    print('GET METHOD RESPONSE $responseJson');
    return responseJson;
  }

  ///This method is used to make API call in POST
  Future<dynamic> requestInPost(String url, String tokens, String body) async {
    print(url);
    var request = "'$body'";
    print('Request body is $request');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": tokens != null ? "Bearer " + tokens : null
    };
    var responseJson;
    try {
      final response = await http
          .post(url, body: body == null ? null : body, headers: headers)
          .timeout(Duration(seconds: 20));
      print('Response Code is  ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException catch (error) {
      print('Socket Exception');
      SocketException socketException = error;
      var map = '{"msg":  "${socketException.message.toString()}"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    } on TimeoutException catch (_) {
      print('Timeout Exception');
      var map = '{"msg": "Timeout"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    } catch (error) {
      print('Format Exception');
      //  FormatException formatException = error;
      var map = '{"msg": "Format Exception"}';
      responseJson = ErrorModel.fromJson(json.decode(map));
    }
    print('response model is $responseJson');

    return responseJson;
  }

  ///Exception handling based on result codes
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return response.body;
      case 201:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      case 400:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      case 401:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      case 403:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      case 422:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      case 500:
        final errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      default:
        var map = '{"msg": "Something went wrong"}';
        final errorModel = ErrorModel.fromJson(json.decode(map));
        return errorModel;
    }
  }
}
