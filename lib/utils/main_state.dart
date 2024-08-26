import 'package:flutter/material.dart';

class MainState with ChangeNotifier {
//底部4个模块
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners(); // 通知所有监听器
  }
}
