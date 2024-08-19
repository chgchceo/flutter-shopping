// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int status;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  UserInfo userInfo;

  Data({
    required this.userInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userInfo: UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "userInfo": userInfo.toJson(),
      };
}

class UserInfo {
  int userId;
  String mobile;
  String nickName;
  int avatarId;
  String gender;
  String country;
  String province;
  String city;
  int addressId;
  String balance;
  int points;
  String payMoney;
  String expendMoney;
  int gradeId;
  String platform;
  int lastLoginTime;
  dynamic currentOauth;
  dynamic avatar;
  dynamic grade;

  UserInfo({
    required this.userId,
    required this.mobile,
    required this.nickName,
    required this.avatarId,
    required this.gender,
    required this.country,
    required this.province,
    required this.city,
    required this.addressId,
    required this.balance,
    required this.points,
    required this.payMoney,
    required this.expendMoney,
    required this.gradeId,
    required this.platform,
    required this.lastLoginTime,
    required this.currentOauth,
    required this.avatar,
    required this.grade,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["user_id"],
        mobile: json["mobile"],
        nickName: json["nick_name"],
        avatarId: json["avatar_id"],
        gender: json["gender"],
        country: json["country"],
        province: json["province"],
        city: json["city"],
        addressId: json["address_id"],
        balance: json["balance"],
        points: json["points"],
        payMoney: json["pay_money"],
        expendMoney: json["expend_money"],
        gradeId: json["grade_id"],
        platform: json["platform"],
        lastLoginTime: json["last_login_time"],
        currentOauth: json["currentOauth"],
        avatar: json["avatar"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile": mobile,
        "nick_name": nickName,
        "avatar_id": avatarId,
        "gender": gender,
        "country": country,
        "province": province,
        "city": city,
        "address_id": addressId,
        "balance": balance,
        "points": points,
        "pay_money": payMoney,
        "expend_money": expendMoney,
        "grade_id": gradeId,
        "platform": platform,
        "last_login_time": lastLoginTime,
        "currentOauth": currentOauth,
        "avatar": avatar,
        "grade": grade,
      };
}
