import 'package:flutter/material.dart';

import 'dart:async';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print("1234");
      // 检测是否滚动到底部
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        // 这里可以调用加载更多的方法
        // MyData.loadMoreData().then((_) => setState(() {})); // 更新UI

        print("加载更多");
      } else {
        print("object23");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("订单列表"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("object");
        },
        child: SingleChildScrollView(
          // slivers: [
          controller: _scrollController,

          child: Column(
            children: [
              SizedBox(
                height: 500,
                child: Text("data"),
              ),
            ],
          ),
          // ],
        ),
      ),
    );
  }
}
