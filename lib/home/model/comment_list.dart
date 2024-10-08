// To parse this JSON data, do
//
//     final CommentListModel = CommentListModelFromJson(jsonString);

import 'dart:convert';

CommentListModel commentListModelFromJson(String str) =>
    CommentListModel.fromJson(json.decode(str));

String commentListModelToJson(CommentListModel data) =>
    json.encode(data.toJson());

class CommentListModel {
  int status;
  String message;
  Data data;

  CommentListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CommentListModel.fromJson(Map<String, dynamic> json) =>
      CommentListModel(
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
  List<ListElement> list;
  int total;

  Data({
    required this.list,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
      };
}

class ListElement {
  int commentId;
  int score;
  String content;
  int isPicture;
  int userId;
  int storeId;
  DateTime createTime;
  User user;

  ListElement({
    required this.commentId,
    required this.score,
    required this.content,
    required this.isPicture,
    required this.userId,
    required this.storeId,
    required this.createTime,
    required this.user,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        commentId: json["comment_id"],
        score: json["score"],
        content: json["content"],
        isPicture: json["is_picture"],
        userId: json["user_id"],
        storeId: json["store_id"],
        createTime: DateTime.parse(json["create_time"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "score": score,
        "content": content,
        "is_picture": isPicture,
        "user_id": userId,
        "store_id": storeId,
        "create_time": createTime.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  int userId;
  String nickName;
  int avatarId;
  dynamic avatarUrl;
  dynamic avatar;

  User({
    required this.userId,
    required this.nickName,
    required this.avatarId,
    required this.avatarUrl,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        nickName: json["nick_name"],
        avatarId: json["avatar_id"],
        avatarUrl: json["avatar_url"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nick_name": nickName,
        "avatar_id": avatarId,
        "avatar_url": avatarUrl,
        "avatar": avatar,
      };
}
