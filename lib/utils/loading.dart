import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  static void show(BuildContext context) {

      // 这里是你想要延时执行的代码
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => Theme(
          data:
              Theme.of(ctx).copyWith(dialogBackgroundColor: Colors.transparent),
          child: const Loading(),
        ),
      );
    
  }

  static void dismiss(context) {

      // 这里是你想要延时执行的代码
        Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 120,
          height: 120,
          alignment: Alignment.center,
          child:const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SpinKitFadingCircle(
                color: Colors.black,
                size: 46.0,
              ),
              SizedBox(height: 15,),
              Text("正在加载",style: TextStyle(fontSize: 19,color: Colors.black,decoration: TextDecoration.none),)
            ],
          ),
        ),
      ),
    );
  }
}