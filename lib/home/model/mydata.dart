import 'package:flutter/material.dart';
import 'package:fluttershopping/utils/toast_helper.dart';

class MyData with ChangeNotifier {
  int _count = 1;

  int get count => _count;

  bool _isAll = true;

  bool get isAll => _isAll;

  void changeIsAll(bool value) {
    _isAll = value;
    notifyListeners(); // 通知所有监听器
  }

  //count设置为一
  void setCount(int num) {
    _count = num;
    notifyListeners(); // 通知所有监听器
  }

  //count加一
  void increment() {
    _count++;
    notifyListeners(); // 通知所有监听器
  }

  //count减一
  void reduce() {
    if (_count <= 1) {
      ToastHelper.showToast("不能小于1");
      return;
    }
    _count--;
    notifyListeners(); // 通知所有监听器
  }
}
