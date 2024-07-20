// To parse this JSON data, do
//
//     final BaseModel = BaseModelFromJson(jsonString);

import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  String message;
  int status;

  BaseModel({
    required this.message,
    required this.status,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
