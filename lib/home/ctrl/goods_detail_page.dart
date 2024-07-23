import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/base_get_request.dart';
import 'package:fluttershopping/home/model/comment_list.dart';
import 'package:fluttershopping/home/model/goods_detail.dart';
import 'package:fluttershopping/home/model/home_model.dart';
import 'package:fluttershopping/home/view/home_subview.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/utils/loading.dart';

class GoodsDetailPage extends StatefulWidget {
  final String? goodsId;
  const GoodsDetailPage({super.key, this.goodsId});

  @override
  State<GoodsDetailPage> createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  Detail? detail;
  List<Datum>? bannerData; //banner图片数组

  List<ListElement>? list; //评论数据

  var num = 1;

  @override
  void initState() {
    super.initState();

    initData();
    initCommentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("商品详情"),
        ),
        body: mainView());
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

  Widget mainView() {
    if (detail == null || detail!.goodsName.isEmpty) {
      return const Text("");
    } else {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 80 - 120,
            child: ListView(children: [
              BannerView(),
              const SizedBox(height: 15),
              topPriceView(),
              nameView(),
              intrduceView(),
              const SizedBox(height: 15),
              commentTitle(),
              commentView(),
              Image.asset("images/img1.png")
            ]),
          ),
          bottomView()
        ],
      );
    }
  }

  Widget commentView() {
    if (list == null || list!.isEmpty) {
      return const Center(
        child: Text(""),
      );
    } else {
      return SizedBox(
          height: (list?.length ?? 0) * 130.0,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list?.length,
            itemBuilder: (BuildContext context, int index) {
              ListElement m = list![index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        m.user.avatarUrl,
                        width: 30,
                      ),
                      Text(m.user.nickName),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(m.content),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(m.createTime.toString()),
                    ],
                  ),
                ],
              );
            },
          ));
    }
  }

  Widget commentTitle() {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        Text(
          "商品评价(${list?.length ?? "0"})条",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Text(
          "查看更多",
          style: TextStyle(fontSize: 16),
        ),
        Image.asset(
          "images/right.png",
          width: 20,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 25,
        )
      ],
    );
  }

  Widget intrduceView() {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                "images/xuanzhong.png",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "七天无理由退货",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                "images/xuanzhong.png",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "48小时发货",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const Spacer(),
              Image.asset(
                "images/right.png",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget bottomView() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.white,
          // border: BoxBorder.top(color:Colors.red)
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              //返回上一层
              // Navigator.of(context).pop();
              //返回最外层
              Navigator.of(context)
                  .popUntil((Route<dynamic> route) => route.isFirst);
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.home, color: Colors.grey), Text("首页")],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.grey,
              ),
              Text("购物车")
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              // _showBottomSheet();
              _showModalBottomSheet("加入购物车");
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
                foregroundColor: WidgetStateProperty.all(Colors.white)),
            child: const Text("加入购物车"),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              _showModalBottomSheet("立即购买");
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
                foregroundColor: WidgetStateProperty.all(Colors.white)),
            child: const Text("立即购买"),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 390,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      detail!.goodsImage,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "¥",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            detail!.goodsPriceMin,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text("库存${detail!.goodsSales}"),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "数量",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (num > 1) {
                        setState(() {
                          num -= 1;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Text(
                        "-",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 30,
                    color: Colors.grey.withOpacity(0.5),
                    child: Text(num.toString()),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        num++;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      color: Colors.grey.withOpacity(0.5),
                      child: const Text(
                        "+",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orange),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    minimumSize: WidgetStateProperty.all(const Size(350, 45))),
                child: Text(title),
              )
            ],
          ),
        );
      },
    );
  }

  Widget topPriceView() {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          // width: MediaQuery.of(context).size.width - 330,
          child: Text(
            detail!.goodsPriceMin,
            style: const TextStyle(
                fontSize: 22, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          detail!.goodsPriceMax,
          style: const TextStyle(
              decoration: TextDecoration.lineThrough, fontSize: 16),
        ),
        Spacer(),
        Text("销量${detail!.goodsSales}"),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget nameView() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Text(
                detail!.goodsName,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void initData() async {
    Future.delayed(const Duration(seconds: 0), () {
      // 这里是你想要延时执行的代码
      Loading.show(context);
      // showLoadingDialog(context, "加载中");
    });

    BaseGetRequest request = BaseGetRequest();

    request.add("s", "api/goods/detail");
    request.add("goodsId", widget.goodsId ?? "");

    var res = await HiNet.getInstance().send(request);
    GoodsDetailModel model =
        GoodsDetailModel.fromJson(jsonDecode(res.toString()));

    if (model.status == 200) {
      var list = model.data.detail.goodsImages;
      List<Datum> data = [];
      for (GoodsImage element in list) {
        Datum mo = Datum();
        mo.imgUrl = element.previewUrl;
        data.add(mo);
      }
      setState(() {
        detail = model.data.detail;
        bannerData = data;
        Future.delayed(const Duration(seconds: 0), () {
          // 这里是你想要延时执行的代码
          Loading.dismiss(context);
          // hideLoadingDialog(context);
        });
      });
    }
  }

  void initCommentData() async {
    BaseGetRequest request = BaseGetRequest();

    request.add("s", "api/comment/listRows");
    request.add("goodsId", widget.goodsId ?? "");
    request.add("limit", "3");

    var res = await HiNet.getInstance().send(request);
    CommentListModel model =
        CommentListModel.fromJson(jsonDecode(res.toString()));
    print(res);
    if (model.status == 200) {
      setState(() {
        list = model.data.list;
      });
    }
  }
}
