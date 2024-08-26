import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershopping/apis/base_post_request.dart';
import 'package:fluttershopping/cart/model/crat_list.dart';
import 'package:fluttershopping/home/ctrl/goods_detail_page.dart';
import 'package:fluttershopping/home/model/mydata.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/mine/model/base_model.dart';
import 'package:fluttershopping/utils/http_service.dart';
import 'package:fluttershopping/utils/main_state.dart';
import 'package:fluttershopping/utils/my_icons.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';
import 'package:fluttershopping/utils/sp_utils.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late int cartTotal = 0;
  late List<ListElement> list = [];
  var selList = 0; //选中的商品数量
  var selCount = 0.0; //选中的商品的总价
  late bool isEdit = false; //是否是编辑删除状态，默认是否
  @override
  void initState() {
    super.initState();

    initData();
  }

//加载页面数据
  initData() async {
    await SPUtil.init();
    var res = await HttpService.get("/cart/list", context);
    BaseModel model = BaseModel.fromJson(jsonDecode(res.toString()));
    if (model.status == 200) {
      CartListModel model = CartListModel.fromJson(jsonDecode(res.toString()));
      setState(() {
        cartTotal = model.data.cartTotal;
        list = model.data.list;
        updateCount();
      });
    }
  }

  updateCount() {
    selCount = 0;
    selList = 0;
    for (var element in list) {
      if (element.isSelected) {
        selList++;
        print("1233");
        selCount +=
            element.goodsNum * double.parse(element.goods.goodsPriceMin);
        print(selCount);
      }
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
              onPressed: () {
                setState(() {
                  isEdit = !isEdit;
                  if (isEdit) {
                    //取消全选状态
                    context.read<MyData>().changeIsAll(false);
                    list.map((m) => m.isSelected = false).toList();
                    updateCount();
                  } else {
                    //全选
                    context.read<MyData>().changeIsAll(true);
                    list.map((m) => m.isSelected = true).toList();
                    updateCount();
                  }
                });
              },
              child: Row(
                children: [
                  isEdit ? const Text("") : const Icon(Icons.edit),
                  Text(
                    isEdit ? "完成" : "编辑",
                    style: TextStyle(
                        fontSize: 18,
                        color: isEdit ? Colors.red : Colors.black),
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
            return GestureDetector(
              onTap: () {
                ListElement element = list[index];
                NavigatorUtils.pushPage(
                    context: context,
                    targetPage: GoodsDetailPage(
                      goodsId: element.goodsId.toString(),
                    ),
                    dismissCallBack: (v) {});
              },
              child: itemView(list[index]),
            );
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
      updateCount();
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
          Text(
            "$selCount",
            style: const TextStyle(color: Colors.red, fontSize: 20),
          ),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                //购物车删除商品
                delGoods();
              } else {
                //去支付
              }
            },
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                minimumSize: WidgetStatePropertyAll(Size(110, 40))),
            child: isEdit
                ? const Text(
                    "删除",
                    style: TextStyle(fontSize: 18),
                  )
                : Text("去结算($selList)", style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  //购物车删除商品
  delGoods() async {
    var ids = [];
    for (var element in list) {
      if (element.isSelected) {
        ids.add(element.id);
      }
    }
    // Map<String, dynamic> data = {"cartIds", ids} as Map<String, dynamic>;
    var res = await HttpService.post("/cart/clear", {"cartIds", ids}, context);

    print(res);
    //刷新数据
    initData();
  }

  goPay() {}

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
            onPressed: () {
              context.read<MainState>().changeCurrentIndex(0);
            },
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

              //更新是否全选按钮状态
              List arr =
                  list.where((element) => element.isSelected == false).toList();

              if (arr.isEmpty) {
                context.read<MyData>().changeIsAll(true);
              } else {
                context.read<MyData>().changeIsAll(false);
              }
              updateCount();
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
                child: Text(
                  element.goods.goodsName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
                      if (element.goodsNum > 1) {
                        element.goodsNum--;
                        updateCount();
                        setState(() {});
                      }
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
                      element.goodsNum++;
                      updateCount();
                      setState(() {});
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
