// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class Loading extends StatelessWidget {
//   const Loading(BuildContext context, {super.key});

//   static void show(BuildContext context) {

//     showDialog(
//       barrierDismissible: true,
//       context: context,
//       builder: (ctx) => Theme(
//         data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
//         child: Loading(),
//       ),
//     );
//   }

//   static void dismiss(context) {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           width: 60,
//           height: 60,
//           alignment: Alignment.center,
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SpinKitFadingCircle(
//                 color: Colors.black,
//                 size: 46.0,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  // 不需要构造函数中的context

  // 静态方法显示加载对话框
  static void show(BuildContext context) {
    showDialog(
      barrierDismissible: false, // 通常不希望用户通过点击外部来关闭加载对话框
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
        child: Dialog(
          child: Loading(), // 直接使用Loading组件作为对话框的子组件
        ),
      ),
    );
  }

  // 静态方法关闭加载对话框
  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 这里不需要设置color为transparent，因为Dialog会处理背景
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SpinKitFadingCircle(
                color: Colors.black,
                size: 46.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
