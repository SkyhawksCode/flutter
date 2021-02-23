// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  String type;
  String msg;
  String data;

  ErrorModel({
    this.type,
    this.msg,
    this.data,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    type: json["type"] == null ? null : json["type"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data,
  };
}
