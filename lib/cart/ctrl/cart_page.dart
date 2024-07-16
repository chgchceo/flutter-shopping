
import 'package:flutter/material.dart';
import 'package:fluttershopping/utils/LoadingPage.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {


// 创建一个ProgressDialog实例  
// ProgressDialog progressDialog = ProgressDialog(context);  
  
// // 显示进度对话框  
// progressDialog.show();  
  
// // 隐藏进度对话框  
// progressDialog.hide();

    return Scaffold(

      appBar: AppBar(

        title: const Text("购物车"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(onPressed: ()=>{

          showLoadingDialog(context, "加载中...")
        }, 
        child: const Text("loading"),)
        ),
    
    );
  }
}