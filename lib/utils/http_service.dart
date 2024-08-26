import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/sp_utils.dart';
import 'package:fluttershopping/utils/toast_helper.dart';

class HttpService {
  // 创建Dio实例
  static final Dio dio = Dio(BaseOptions(
    baseUrl: "http://smart-shop.itheima.net/index.php?s=/api/", // 你的API基础URL
    connectTimeout: const Duration(seconds: 20), // 连接超时时间
    receiveTimeout: const Duration(seconds: 10), // 接收超时时间
  ));

  // 封装GET请求
  static Future<Response> get(String path, BuildContext context,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var toke = await SPUtil.getString("token");
      print(toke.toString());
      var options =
          Options(headers: {"Access-Token": toke.toString(), "platform": "H5"});
      // 发送GET请求
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        Loading.show(context);
      });

      Response response = await dio.get(path,
          queryParameters: queryParameters, options: options);

      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        // ignore: use_build_context_synchronously
        Loading.dismiss(context);
        // hideLoadingDialog(context);
      });
      // 处理响应
      return response;
    } catch (error) {
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        // ignore: use_build_context_synchronously
        Loading.dismiss(context);
        // hideLoadingDialog(context);
      });
      // 错误处理
      rethrow;
    }
  }

  // 封装POST请求
  static Future<Response> post(
      String path, Object? data, BuildContext context) async {
    print(data);
    try {
      var toke = await SPUtil.getString("token");
      print(toke.toString());
      var options = Options(headers: {
        "Access-Token": toke.toString(),
        "platform": "H5",
        // "Content-Type": "application/json"
      });
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        Loading.show(context);
      });
      // 发送POST请求
      Response response = await dio.post(path, data: data, options: options);
      // 处理响应
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        Loading.dismiss(context);
        // hideLoadingDialog(context);
      });
      return response;
    } catch (error) {
      ToastHelper.showToast(error.toString());
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        Loading.dismiss(context);
        // hideLoadingDialog(context);
      });
      // 错误处理
      throw error;
    }
  }
}

// // 使用示例
// // 假设你有一个API端点来获取用户信息
// void fetchUserInfo(String userId) async {
//   try {
//     Response response = await HttpService.get("/users/$userId");
//     if (response.statusCode == 200) {
//       // 处理成功响应
//       print(response.data);
//     } else {
//       // 处理错误响应
//       print("Error fetching user info");
//     }
//   } catch (error) {
//     // 错误处理
//     print("An error occurred: $error");
//   }
// }

// // 假设你有一个API端点来添加用户
// void addUser(String username, String email) async {
//   try {
//     Map<String, dynamic> userData = {"username": username, "email": email};
//     Response response = await HttpService.post("/users", userData);
//     if (response.statusCode == 201) {
//       // 处理成功响应
//       print("User added successfully");
//     } else {
//       // 处理错误响应
//       print("Error adding user");
//     }
//   } catch (error) {
//     // 错误处理
//     print("An error occurred: $error");
//   }
// }
