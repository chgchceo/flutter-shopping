import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {
  //普通打开页面的方法
  static void pushPage(
      {required BuildContext context,
      required Widget targetPage,
      bool isReplace = false, //是否替换当前界面
       required Function(dynamic value) dismissCallBack}) {
    PageRoute pageRoute;

    if (Platform.isAndroid) {
      pageRoute = MaterialPageRoute(builder: (BuildContext context) {
        return targetPage;
      });
    } else {
      pageRoute = CupertinoPageRoute(builder: (BuildContext context) {
        return targetPage;
      });
    }

    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        dismissCallBack(value);
            });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        dismissCallBack(value);
            });
    }
  }

  //自定义页面打开方式
  static void pushPageByFade({
    required BuildContext context,
    required Widget targetPage,
    bool isReplace = false,
    bool opaque = false, //
    required Function(dynamic value) dismissCallBack,
  }) {
    PageRoute pageRoute = PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return targetPage;
      },

      transitionDuration: const Duration(milliseconds: 1200),
      //动画
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        dismissCallBack(value);
            });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        dismissCallBack(value);
            });
    }
  }
}
