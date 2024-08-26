import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/author_get_request.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/mine/ctrl/login_page.dart';
import 'package:fluttershopping/mine/ctrl/order_list.dart';
import 'package:fluttershopping/mine/model/base_model.dart';
import 'package:fluttershopping/mine/model/user_model.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttershopping/utils/sp_utils.dart';
import 'package:fluttershopping/utils/toast_helper.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => MinePageState();
}

class MinePageState extends State<MinePage> {
  var username = "";
  var phone = "";
  var isLogin = false;

  @override
  void initState() {
    super.initState();

    initData();
  }

  //判断用户是否登录
  initData() async {
    await SPUtil.init();
    var token = await SPUtil.getString("token");

    if (token.toString().length > 5) {
      print(token.toString().length);
      print(token.toString());
      print("123456");
      setState(() {
        isLogin = true;
      });
      //已登录
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        // ignore: use_build_context_synchronously
        Loading.show(context);
      });
      AuthorGetRequest request = AuthorGetRequest();
      request.add("s", "api/user/info");
      request.addHeader("Access-Token", token as Object);
      request.addHeader("platform", "H5");

      var res = await HiNet.getInstance().send(request);
      print(res);
      BaseModel model = BaseModel.fromJson(jsonDecode(res.toString()));

      if (model.status == 200) {
        UserModel model2 = UserModel.fromJson(jsonDecode(res.toString()));

        setState(() {
          username = model2.data.userInfo.nickName;
          phone = model2.data.userInfo.mobile;
          print(username);
          print(phone);
        });
      } else {
        //
        ToastHelper.showToast(model.message);
      }
      Future.delayed(const Duration(seconds: 0), () {
        // 这里是你想要延时执行的代码
        Loading.dismiss(context);
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  void _showTemperatureTip() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('温馨提示'),
          titlePadding: const EdgeInsets.only(left: 100, top: 20),
          content: const Text('确定要退出当前登录吗?'),
          backgroundColor: Colors.white,
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              child: const Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              child: const Text('确定'),
              onPressed: () {
                SPUtil.saveObject("token", "");
                setState(() {
                  isLogin = false;
                });
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (result ?? false) {
      // 用户点击了确认
      print('User confirmed.');
    } else {
      // 用户点击了取消
      print('User cancelled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(ScreenUtil().screenWidth);
    // print(ScreenUtil().bottomBarHeight);
    // print(ScreenUtil().statusBarHeight);
    // print(kToolbarHeight);
    // print(MediaQuery.of(context).padding.top);
    // print(ScreenUtil().screenHeight);

    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        // backgroundColor: Colors.red,
        body: RefreshIndicator(
            onRefresh: () async {
              // // 模拟网络请求
              // await Future.delayed(Duration(seconds: 2));
              // // 这里可以添加数据更新的代码
              // // 注意：在真实应用中，你可能需要在这里调用一个方法来更新你的数据源
              // print('数据已刷新');
              initData();
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: ScreenUtil().screenHeight -
                      ScreenUtil().bottomBarHeight -
                      35 -
                      5 -
                      ScreenUtil().statusBarHeight,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: topView(),
                            onTap: () {
                              if (!isLogin) {
                                NavigatorUtils.pushPage(
                                    context: context,
                                    targetPage: const LoginPage(),
                                    dismissCallBack: (v) {
                                      initData();
                                    });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          topItem(),
                          const SizedBox(
                            height: 10,
                          ),
                          midItem(),
                          const SizedBox(
                            height: 10,
                          ),
                          bottomItem(),
                          const SizedBox(
                            height: 10,
                          ),
                          isLogin
                              ? ElevatedButton(
                                  onPressed: () => {
                                    // Loading.show(context)
                                    // ToastHelper.showToast("确定要退出登录吗")
                                    _showTemperatureTip()
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.white), // 设置按钮颜色
                                    minimumSize: WidgetStateProperty.all<Size>(
                                        Size(
                                            MediaQuery.of(context).size.width -
                                                30,
                                            50)), // 设置按钮最小大小
                                    maximumSize: WidgetStateProperty.all<Size>(
                                        const Size(400, 60)), // 设置按钮最大大小
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  child: const Text("退出登录"),
                                )
                              : Text(""),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget topView() {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        ClipOval(
          child: SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(
              "images/img1.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(isLogin ? username : "未登录",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    isLogin ? phone : "前往登录",
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget bottomItem() {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 230,
        // color: Colors.white,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "其它功能",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          //   Row(
          // children: [

          SizedBox(
            height: 160,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 3, //widget 左右间的距离
                mainAxisSpacing: 2, //widget 上下间的距离
                crossAxisCount: 4, //每行列数)
                childAspectRatio: 1.1,
                children: [
                  imgItem(Icons.all_inbox, "全部订单"),
                  imgItem(Icons.card_travel, "待支付"),
                  imgItem(Icons.snapchat_outlined, "待发货"),
                  imgItem(Icons.card_travel_sharp, "待收货"),
                  imgItem(Icons.card_travel_sharp, "已完成"),
                ]),
          )
        ]
            // ),
            // ],
            ));
  }

  Widget midItem() {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 100,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Row(
        children: [
          imgItem(Icons.all_inbox, "全部订单"),
          imgItem(Icons.card_travel, "待支付"),
          imgItem(Icons.snapchat_outlined, "待发货"),
          imgItem(Icons.card_travel_sharp, "待收货"),
          imgItem(Icons.card_travel_sharp, "已完成"),
        ],
      ),
    );
  }

  Widget topItem() {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 100,
      // color: Colors.white,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Row(
        children: [
          item("20", "全部订单"),
          item("30", "待支付"),
          item("40", "待发货"),
          item("10", "待收货"),
        ],
      ),
    );
  }

  Widget item(String v, String name) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30) / 4.0,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            v,
            style: const TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget imgItem(IconData v, String name) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30) / 5.0,
      height: 60,
      child: GestureDetector(
        onTap: () {
          NavigatorUtils.pushPage(
              context: context,
              targetPage: const OrderListPage(),
              dismissCallBack: (v) {});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(v),
            const SizedBox(
              height: 10,
            ),
            Text(name, style: const TextStyle(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
