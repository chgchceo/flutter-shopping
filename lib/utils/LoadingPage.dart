import 'package:flutter/material.dart'; 
import 'dart:ui'; 
  
class CustomLoadingDialog extends StatelessWidget {  
  final String message; // 加载提示消息  
  
  // 构造函数，允许外部传入消息  
  const CustomLoadingDialog({Key? key, required this.message}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    // 创建一个Dialog，里面包含加载消息和进度指示器  
    return Dialog(  
      shape: RoundedRectangleBorder(  
        borderRadius: BorderRadius.circular(12.0),  
      ), // 可选：设置Dialog的边框形状  
      elevation: 0.0, // 可选：设置Dialog的阴影大小  
      backgroundColor: Colors.transparent, // 可选：设置Dialog的背景色 
      child: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(  
            // color: Colors.white.withOpacity(0.9 ), // 设置背景色和透明度  
            color: Colors.transparent,
            // borderRadius: BorderRadius.circular(12.0),  
          ),
        child: BackdropFilter(  
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // 可选：给Dialog添加模糊效果  
        child: Container( 
          width: 100, 
          height: 100,
          decoration: BoxDecoration(  
            // color: Colors.white.withOpacity(0.9 ), // 设置背景色和透明度  
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),  
          ),  
  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30), // 水平20，垂直40  

          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12.0),  
            ),
            child: Center(  
            // mainAxisSize: MainAxisSize.min,  
            child: Column(
              children: <Widget>[  
                SizedBox(
                  width: 100,
                  height: 140,
                  child: Column(
                    children: [
              const SizedBox(height: 30.0), 
              const CircularProgressIndicator(  
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                 // 设置进度指示器的颜色  
                 
              ),
              const SizedBox(height: 20.0), 
              Text(  
                message,  
                style: const TextStyle(  
                  fontSize: 16.0,  
                  color: Colors.white,  
                ),  
                textAlign: TextAlign.center,  
              ) 
                    ],
                  ),
                ) 
            ],
            )  
          ),
          )
        ),  
      ), 
      ), 
       
    );  
  }  
}  
  
// 在你的页面中显示这个自定义加载提示框  
// 假设你有一个函数叫showLoadingDialog，它接受一个BuildContext和一个消息字符串  
void showLoadingDialog(BuildContext context, String message) {  
  // 使用Navigator的of方法获取当前的Navigator，并显示Dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return CustomLoadingDialog(message: message);  
    },  
  );  
}  


// 隐藏加载提示框的函数  
// 注意：这个函数需要一个与显示Dialog时相同的BuildContext或其子context  
void hideLoadingDialog(BuildContext context) {  
  // 使用Navigator.of(context)来获取与context相关联的Navigator  
  // 然后调用pop方法来关闭最顶层的Dialog  
  Navigator.of(context).pop();  
}  
  