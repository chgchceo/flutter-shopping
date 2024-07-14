
import 'package:flutter/foundation.dart';

class LogUtils{


  //是否输入日志标识
  static bool isLog =  ! const bool.fromEnvironment("dart.vm.product");//是否是生产环境

  static String tag = "flutter_myApp | ";
  static void e(String message){

    if(isLog){

      if (kDebugMode) {
        print("$tag $message");
      }
    }
  }
}