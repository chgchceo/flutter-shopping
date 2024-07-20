// To parse this JSON data, do
//
//     final ImageCodeModel = ImageCodeModelFromJson(jsonString);

import 'dart:convert';

ImageCodeModel imageCodeModelFromJson(String str) => ImageCodeModel.fromJson(json.decode(str));

String imageCodeModelToJson(ImageCodeModel data) => json.encode(data.toJson());

class ImageCodeModel {
  int status;
  String message;
  Data data;

  ImageCodeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ImageCodeModel.fromJson(Map<String, dynamic> json) => ImageCodeModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String base64;
  String key;
  String md5;

  Data({
    required this.base64,
    required this.key,
    required this.md5,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        base64: json["base64"],
        key: json["key"],
        md5: json["md5"],
      );

  Map<String, dynamic> toJson() => {
        "base64": base64,
        "key": key,
        "md5": md5,
      };
}
