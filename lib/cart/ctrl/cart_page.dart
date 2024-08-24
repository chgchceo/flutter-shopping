import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershopping/cart/model/crat_list.dart';
import 'package:fluttershopping/home/ctrl/goods_detail_page.dart';
import 'package:fluttershopping/home/model/mydata.dart';
import 'package:fluttershopping/mine/model/base_model.dart';
import 'package:fluttershopping/utils/http_service.dart';
import 'package:fluttershopping/utils/my_icons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int cartTotal = 0;
  late List<ListElement> list = [];
  @override
  void initState() {
    super.initState();

    initData();
  }

//加载页面数据
  initData() async {
    var res = await HttpService.get("/cart/list", context);
    BaseModel model = BaseModel.fromJson(jsonDecode(res.toString()));
    if (model.status == 200) {
      CartListModel model = CartListModel.fromJson(jsonDecode(res.toString()));
      setState(() {
        cartTotal = model.data.cartTotal;
        list = model.data.list;
      });
    }
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
      return mainViewHasNullList();
    }
    return mainViewHasList();
  }

//有数据
  Widget mainViewHasList() {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Column(
        children: [topView(), midView(), bottomView()],
      ),
    );
  }

  Widget topView() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          const Text(
            "共",
            style: TextStyle(fontSize: 18),
          ),
          Text(cartTotal.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.red)),
          const Text("件商品", style: TextStyle(fontSize: 18)),
          const Spacer(),
          TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(Icons.edit),
                  Text(
                    "编辑",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              )),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  Widget midView() {
    return Container(
      height: ScreenUtil().screenHeight -
          kToolbarHeight -
          50 -
          50 -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.top -
          kBottomNavigationBarHeight,
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return itemView(list[index]);
          }),
      // color: Colors.red,
    );
  }

  changeCheckStatus() {
    final myData = Provider.of<MyData>(context, listen: false);
    bool isAll = myData.isAll;
    context.read<MyData>().changeIsAll(!isAll);
    setState(() {
      list.map((m) => m.isSelected = !isAll).toList();
    });
  }

  Widget bottomView() {
    bool isAll = context.watch<MyData>().isAll;
    return Container(
      color: Colors.white,
      height: 65,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          TextButton(
              onPressed: () {
                changeCheckStatus();
              },
              child: Row(
                children: [
                  Icon(
                    isAll ? MyIcons.sel : MyIcons.unsel,
                    color: isAll ? Colors.blue : Colors.grey,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("全选")
                ],
              )),
          const Spacer(),
          const Text("合计:"),
          const Text("23.00"),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("去结算")),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

//没有数据
  Widget mainViewHasNullList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/cart-empty.png",
            color: Colors.grey.withOpacity(0.4),
            width: 120,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "您的购物车是空的，快去逛逛吧！",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              minimumSize: WidgetStateProperty.all<Size>(const Size(150, 45)),
            ),
            child: const Text("去逛逛"),
          )
        ],
      ),
    );
  }

  Widget itemView(ListElement element) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: const EdgeInsets.all(15),
      width: ScreenUtil().screenWidth - 30,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // height: 130,
      child: Row(
        children: [
          // const Icon(Icons.select_all),
          GestureDetector(
            onTap: () {
              element.isSelected = !element.isSelected;
              setState(() {});
            },
            child: Icon(
              element.isSelected ? MyIcons.sel : MyIcons.unsel,
              color: element.isSelected ? Colors.blue : Colors.grey,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              element.goods.goodsImage,
              fit: BoxFit.contain,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth - 220,
                child: Text(element.goods.goodsName),
              ),
              Row(
                children: [
                  Text(
                    "¥${element.goods.goodsPriceMin}",
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (num > 1) {
                      //   setState(() {
                      //     num -= 1;
                      //   });
                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 30,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Text(
                        "-",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: Colors.grey.withOpacity(0.5),
                    child: Text(element.goodsNum.toString()),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   num++;
                      // });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 30,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Text(
                        "+",
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
