import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/base_get_request.dart';
import 'package:fluttershopping/home/model/goods_detail.dart';
import 'package:fluttershopping/home/model/home_model.dart';
import 'package:fluttershopping/home/view/home_subview.dart';
import 'package:fluttershopping/http/core/hi_net.dart';

class GoodsDetailPage extends StatefulWidget {
  final String? goodsId;
  const GoodsDetailPage({super.key, this.goodsId});

  @override
  State<GoodsDetailPage> createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  Detail? detail;
  List<Datum>? bannerData; //banner图片数组
  @override
  void initState() {
    super.initState();

    initData();
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
      return const Text("hehe");
    } else {
      return Column(
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height-80-120,
            child: ListView(
              children: [
                BannerView(),
                Column(
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 230,
                          child: Text(
                            detail!.goodsPriceMin,
                            style: const TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Text("销量${detail!.goodsSales}"),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),

          
          Container(
            height: 50,
            
            decoration: const BoxDecoration(
             color: Colors.white,
              // border: BoxBorder.top(color:Colors.red)
              border: Border(top:BorderSide(width: 1,color: Colors.grey))
              
            ),
            child: const Row(

              children: [
                Text("data")
              ],
            ),

          )
        ],
      );
    }
  }

  void initData() async {
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
      });
    }
  }
}
