
import 'package:flutter/material.dart';
import 'package:fluttershopping/utils/loading.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State <MinePage> createState() =>  MinePageState();
}

class  MinePageState extends State <MinePage> {

  @override
  void initState() {

    super.initState();
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
              onPressed: () => Navigator.of(context).pop(true),
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
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: ListView(
          children: [
            Column(
              children: [
               const SizedBox(
                  height: 20,
                ),
                Row(
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
                    const Column(
                      children: [
                        Text("chgch",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("个性签名")
                      ],
                    )
                  ],
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
                ElevatedButton(
                  onPressed: () => {
                    // Loading.show(context)
                    // ToastHelper.showToast("确定要退出登录吗")
                    _showTemperatureTip()
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.white), // 设置按钮颜色
                    minimumSize: WidgetStateProperty.all<Size>(
                        const Size(350, 50)), // 设置按钮最小大小
                    maximumSize: WidgetStateProperty.all<Size>(
                        const Size(360, 60)), // 设置按钮最大大小
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Text("退出登录"),
                )
              ],
            ),
          ],
        ));
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
          Text(name)
        ],
      ),
    );
  }

  Widget imgItem(IconData v, String name) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30) / 5.0,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(v),
          const SizedBox(
            height: 10,
          ),
          Text(name)
        ],
      ),
    );
  }

  void initData() {
    Loading.show(context);
  }
}
