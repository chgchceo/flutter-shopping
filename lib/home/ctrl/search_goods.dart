import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/base_get_request.dart';
import 'package:fluttershopping/home/ctrl/goods_detail_page.dart';
import 'package:fluttershopping/home/model/search_list.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';

// ignore: must_be_immutable
class SearchGoodsPage extends StatefulWidget {
  final String? keyword;
  final String? categoryId;

  const SearchGoodsPage({super.key, this.keyword, this.categoryId});

  @override
  State<SearchGoodsPage> createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  final ScrollController _scrollController = ScrollController();
  var index = 1;
  List<Datum>? data;
  var sortType = "all";
  var hasMore = true;
  @override
  void initState() {
    super.initState();
    initData();
    print(widget.keyword);

    _scrollController.addListener(() {
      print("1111111111111111object");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("222222222222object");

        if (hasMore == false) {
          return;
        }
        index++;
        initData();
      }
    });
  }

  initData() async {
    setState(() {
      if (index == 1) {
        hasMore = true;
        data = [];
      }
    });
    Future.delayed(const Duration(seconds: 0), () {
      // 这里是你想要延时执行的代码
      Loading.show(context);
    });
    BaseGetRequest request = BaseGetRequest();
    request.add("s", "api/goods/list");
    request.add("sortType", sortType);
    request.add("page", index);
    request.add("goodsName", widget.keyword ?? "");
    request.add("categoryId", widget.categoryId ?? "");

    var res = await HiNet.getInstance().send(request);
    SearchListModel model =
        SearchListModel.fromJson(jsonDecode(res.toString()));

    if (model.status == 200) {
      setState(() {
        if (index == 1) {
          data = model.data.list.data;
        } else {
          data = data! + model.data.list.data;
        }

        if (model.data.list.data.length < 15) {
          hasMore = false;
        } else {
          hasMore = true;
        }
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
      appBar: AppBar(
        title: const Text("商品列表"),
        centerTitle: true,
      ),
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
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  140 -
                  MediaQuery.of(context).padding.top,
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
    return RefreshIndicator(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: data!.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == data!.length) {
                if (hasMore) {
                  return const Center(
                    child: Text("加载更多"),
                  );
                } else {
                  return const Center(
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("数据加载完成"),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                }
              }

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
            }),
        onRefresh: () async {
          index = 1;
          initData();
        });
  }

  Widget topButton() {
    return SizedBox(
      child: Row(
        children: [
          const Spacer(),
          TextButton(
              onPressed: () {
                index = 1;
                sortType = "all";
                initData();
              },
              child: Text(
                "综合",
                style: TextStyle(
                    fontSize: 18,
                    color: (sortType == "all") ? Colors.black : Colors.grey),
              )),
          const Spacer(),
          TextButton(
              onPressed: () {
                index = 1;
                sortType = "sales";
                initData();
              },
              child: Text(
                "销量",
                style: TextStyle(
                    fontSize: 18,
                    color: (sortType == "sales") ? Colors.black : Colors.grey),
              )),
          const Spacer(),
          TextButton(
              onPressed: () {
                index = 1;
                sortType = "price";
                initData();
              },
              child: Text("价格",
                  style: TextStyle(
                      fontSize: 18,
                      color:
                          (sortType == "price") ? Colors.black : Colors.grey))),
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
