import 'dart:convert';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  //静态实例
  // static late SharedPreferences _sharedPreferences;
  static SharedPreferences? _sharedPreferences;

  static Future<bool> init() async {
    // _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return true;
  }

  //清除数据
  static void remove(String key) async {
    if (_sharedPreferences!.containsKey(key)) {
      _sharedPreferences!.remove(key);
    }
  }

  //异步保存基本数据类型
  static Future save(String key, dynamic value) async {
    if (value is String) {
      _sharedPreferences!.setString(key, value);
    } else if (value is double) {
      _sharedPreferences!.setDouble(key, value);
    } else if (value is int) {
      _sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      _sharedPreferences!.setBool(key, value);
    } else if (value is List<String>) {
      _sharedPreferences!.setStringList(key, value);
    }
  }

  //异步读取数据
  static Future<String?> getString(String key) async {
    return _sharedPreferences!.getString(key);
  }

  static Future<int?> getInt(String key) async {
    return _sharedPreferences!.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    return _sharedPreferences!.getDouble(key);
  }

  static Future<bool?> getBool(String key) async {
    return _sharedPreferences!.getBool(key);
  }

  static Future<List<String>?> getListString(String key) async {
    return _sharedPreferences!.getStringList(key);
  }

  //保存自定义对象
  static Future saveObject(String key, dynamic value) async {
    //通过 json 将object对象编译成string类型baocun
    _sharedPreferences!.setString(key, json.encode(value));
  }

  //获取自定义对象
  static dynamic getObject(String key) {
    String? data = _sharedPreferences!.getString(key);
    return (data == null || data.isEmpty) ? null : json.decode(data);
  }

  //保存列表数据
  static Future putObjectList(String key, List<Object> list) async {
    List<String> dataList = [];

    for (int i = 0; i < list.length; i++) {
      Object object = list[i];
      String string = json.encode(object);
      dataList.add(string);
    }
    _sharedPreferences!.setStringList(key, dataList);
  }

  static Future<List<Object>> getObjectList(String key) async {
    List<String>? list = _sharedPreferences!.getStringList(key);

    List<Object> data = [];

    for (int i = 0; i < list!.length; i++) {
      String string = list[i];
      Object object = json.decode(string);
      data.add(object);
    }

    return data;
  }
}
