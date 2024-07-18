import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/base_get_request.dart';
import 'package:fluttershopping/home/ctrl/goods_detail_page.dart';
import 'package:fluttershopping/home/model/search_list.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';
import 'package:get/route_manager.dart';

// ignore: must_be_immutable
class SearchGoodsPage extends StatefulWidget {
  final String? keyword;
  final String? categoryId;
  const SearchGoodsPage({super.key, this.keyword, this.categoryId});

  @override
  State<SearchGoodsPage> createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  List<Datum>? data;
  var sortType = "all";
  @override
  void initState() {
    super.initState();
    initData();
    print(widget.keyword);
  }

  initData() async {
    Future.delayed(const Duration(seconds: 0), () {
      // 这里是你想要延时执行的代码
      Loading.show(context);
    });
    BaseGetRequest request = BaseGetRequest();
    request.add("s", "api/goods/list");
    request.add("sortType", sortType);
    request.add("goodsName", widget.keyword ?? "");
    request.add("categoryId", widget.categoryId ?? "");

    var res = await HiNet.getInstance().send(request);
    SearchListModel model =
        SearchListModel.fromJson(jsonDecode(res.toString()));

    if (model.status == 200) {
      setState(() {
        data = model.data.list.data;
        Future.delayed(const Duration(seconds: 0), () {
          // 这里是你想要延时执行的代码
          Loading.dismiss(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("商品列表")),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            topSearch(),
            const SizedBox(
              height: 15,
            ),
            topButton(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 320,
              child: goodsList(),
            )
          ],
        ),
      ),
    );
  }

  Widget goodsList() {
    if (data == null || data!.isEmpty) {
      return const Center(
        child: Text("暂无数据"),
      );
    }
    return ListView.builder(
        itemCount: data?.length,
        itemBuilder: (BuildContext context, int index) {
          Datum model = data![index];
          

          return GestureDetector(
              onTap: () {
                NavigatorUtils.pushPage(
                    context: context,
                    targetPage: GoodsDetailPage(
                      goodsId: model.goodsId.toString(),
                    ),
                    dismissCallBack: (v) {});

              },
              child: Column(children: [
                Divider(
                  color: Colors.grey.withOpacity(0.1),
                  height: 1,
                ),
                Row(children: [
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(model.goodsImage),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          model.goodsName,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("销量${model.goodsSales}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          model.goodsPriceMin,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ])
              ]));
        });
  }

  Widget topButton() {
    return SizedBox(
      child: Row(
        children: [
          const Spacer(),
          TextButton(
              onPressed: () {
                sortType = "all";
                initData();
              },
              child: const Text(
                "综合",
                style: TextStyle(fontSize: 18, color: Colors.black),
              )),
          const Spacer(),
          TextButton(
              onPressed: () {
                sortType = "sales";
                initData();
              },
              child: const Text("销量",
                  style: TextStyle(fontSize: 18, color: Colors.black))),
          const Spacer(),
          TextButton(
              onPressed: () {
                sortType = "price";
                initData();
              },
              child: const Text("价格",
                  style: TextStyle(fontSize: 18, color: Colors.black))),
          const Spacer(),
        ],
      ),
    );
  }

  Widget topSearch() {
    return Row(
      children: [
        const SizedBox(width: 20),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              const Icon(Icons.search),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 190,
                height: 50,
                child: TextField(
                  // 初始文本值
                  // initialValue: '',
                  // 占位符文本
                  decoration: InputDecoration(
                    labelText: widget.keyword,
                    hintText: '请输入搜索关键字',
                    border: InputBorder.none,

                    // 你可以添加更多装饰，比如前缀或后缀图标
                  ),
                  // 当文本改变时调用
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                color: Colors.red,
                width: 100,
                child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "搜索",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
