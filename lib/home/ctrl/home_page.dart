import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershopping/home/ctrl/goods_detail_page.dart';
import 'package:fluttershopping/home/ctrl/search_history.dart';
import 'package:fluttershopping/home/model/home_model.dart';
import 'package:fluttershopping/home/view/home_subview.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/http/request/test_request.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';
import 'package:fluttershopping/utils/sp_utils.dart';

// ignore: prefer_typing_uninitialized_variables
var screenWidth;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  late List<Item> items; //页面整体数组

  List<Datum>? bannerData; //banner图片数组

  List<Datum>? cateData; //导航分类

  List<Datum>? goodsData; //商品列表数组

  @override
  void initState() {
    super.initState();

    // if (bannerData == null) {
    initData();
    // }
  }

//加载首页数据
  void initData() async {
    await SPUtil.init();
    // Future.delayed(const Duration(seconds: 0), () {
    //   // 这里是你想要延时执行的代码
    //   Loading.show(context);
    //   // showLoadingDialog(context,"加载中");
    // });

    TestRequest request = TestRequest();
    request.add("s", "api/page/detail");

    var response = await HiNet.getInstance().send(request);
    HomeModel model = HomeModel.fromJson(jsonDecode(response.toString()));
    if (model.status == 200) {
      setState(() {
        items = model.data.pageData.items;
        // Future.delayed(const Duration(seconds: 0), () {
        //   // 这里是你想要延时执行的代码
        //   Loading.dismiss(context);
        // });

        bannerData = items[1].data;
        cateData = items[3].data;
        goodsData = items[6].data;
        print(goodsData);
      });
    }
  }

//首页界面展示
  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("智慧商城"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       GestureDetector(
      //         child: const SearchButton(),
      //         onTap: () => {
      //           NavigatorUtils.pushPage(
      //               context: context,
      //               targetPage: const SearchHistoryPage(),
      //               dismissCallBack: (e) => {})
      //         },
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       BannerView(),
      //       SizedBox(
      //         height: 200,
      //         child: naviGridView(context, cateData),
      //       ),
      //       SizedBox(
      //         height: (goodsData?.length ?? 0) * 100,
      //         child: goodsList(goodsData),
      //       )
      //     ],
      //   ),
      // ),

      body: RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  child: const SearchButton(),
                  onTap: () => {
                    NavigatorUtils.pushPage(
                        context: context,
                        targetPage: const SearchHistoryPage(),
                        dismissCallBack: (e) => {})
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                BannerView(),
                SizedBox(
                  height: 200,
                  child: naviGridView(context, cateData),
                ),
                SizedBox(
                  height: (goodsData?.length ?? 0) * 150,
                  child: goodsList(goodsData),
                )
              ],
            ),
          ),
          onRefresh: () async {
            initData();
          }),
    );
  }

  // ignore: non_constant_identifier_names
  Widget BannerView() {
    if (bannerData != null && bannerData!.isNotEmpty) {
      return SizedBox(
        height: 200,
        child: BannerCarousel(
          bannerData: bannerData,
        ),
      );
    } else {
      return const Text("");
    }
  }

  @override
  bool get wantKeepAlive => true; // 保持页面活跃
}

@override
bool get wantKeepAlive => true; // 保持页面活跃

Widget goodsList(List<Datum>? data) {
  if (data == null || data.isEmpty) {
    return const Text("");
  }
  print(data.length);
// 使用ListView.builder来构建列表
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),

    itemCount: data.length, // 列表项的数量
    itemBuilder: (context, index) {
      // 获取当前索引对应的Datum对象
      final datum = data[index];

      // 创建一个Widget来表示这个Datum对象
      // 这里只是一个简单的例子，你可以根据需要自定义
      return GestureDetector(
        onTap: () {
          NavigatorUtils.pushPage(
              context: context,
              targetPage: GoodsDetailPage(
                goodsId: datum.goodsId.toString(),
              ),
              dismissCallBack: (v) {});
        },
        child: goodsItem(datum),
      );
    },
  );
}

Widget goodsItem(Datum data) {
  print(data.goodsImage);
  return Column(
    children: [
      Divider(
        height: 2.0, // 设置高度
        color: Colors.blueGrey[100], // 设置颜色
      ),
      Row(
        children: [
          const SizedBox(width: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data.goodsImage!,
              fit: BoxFit.contain,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth - 140,
                child: Text(
                  data.goodsName!,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: screenWidth - 140,
                child: Text("销量:${data.goodsSales}"),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: screenWidth - 140,
                child: Text(data.goodsPriceMin!,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
            ],
          )
        ],
      )
    ],
  );
}

// 假设有一个函数来获取默认图片
Widget getDefaultImage() {
  return Image.asset('assets/images/default_image.png');
}
