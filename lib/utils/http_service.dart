import 'dart:async';
import 'package:dio/dio.dart';
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
  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      // 发送GET请求
      Response response = await dio.get(path, queryParameters: queryParameters);
      // 处理响应
      return response;
    } catch (error) {
      // 错误处理
      throw error;
    }
  }

  // 封装POST请求
  static Future<Response> post(String path, Map<String, dynamic> data) async {
    print(data);
    try {
      var toke = await SPUtil.getString("token");
      print(toke.toString());
      var options =
          Options(headers: {"Access-Token": toke.toString(), "platform": "H5"});
      // 发送POST请求
      Response response = await dio.post(path, data: data, options: options);
      // 处理响应
      return response;
    } catch (error) {
      ToastHelper.showToast(error.toString());
      // 错误处理
      throw error;
    }
  }
}

// 使用示例
// 假设你有一个API端点来获取用户信息
void fetchUserInfo(String userId) async {
  try {
    Response response = await HttpService.get("/users/$userId");
    if (response.statusCode == 200) {
      // 处理成功响应
      print(response.data);
    } else {
      // 处理错误响应
      print("Error fetching user info");
    }
  } catch (error) {
    // 错误处理
    print("An error occurred: $error");
  }
}

// 假设你有一个API端点来添加用户
void addUser(String username, String email) async {
  try {
    Map<String, dynamic> userData = {"username": username, "email": email};
    Response response = await HttpService.post("/users", userData);
    if (response.statusCode == 201) {
      // 处理成功响应
      print("User added successfully");
    } else {
      // 处理错误响应
      print("Error adding user");
    }
  } catch (error) {
    // 错误处理
    print("An error occurred: $error");
  }
}
