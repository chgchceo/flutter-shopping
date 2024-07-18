import 'package:flutter/material.dart';


 
class GoodsDetailPage extends StatefulWidget {

  final String? goodsId;
  const GoodsDetailPage({super.key, this.goodsId});

  @override
  State<GoodsDetailPage> createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title:const Text("商品详情"),
      ),

      body:const Center(child: Text("data"),),
    );
  }
}