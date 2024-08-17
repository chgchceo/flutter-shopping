import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var list = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    if (list.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/cart-empty.png",color: Colors.grey.withOpacity(0.4),width: 120,),
            const SizedBox(height: 40,),
            const Text("您的购物车是空的，快去逛逛吧！",style: TextStyle(fontSize: 18,color: Colors.grey),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                minimumSize: WidgetStateProperty.all<Size>(const Size(150, 45)),
              ), child: const Text("去逛逛"),)
          ],
        ),
      );
    }
    return Container(
      color: Colors.grey.withOpacity(0.1),
    );
  }
}
