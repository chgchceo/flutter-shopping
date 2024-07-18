import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttershopping/apis/category_request.dart';
import 'package:fluttershopping/category/model/category_model.dart';
import 'package:fluttershopping/home/ctrl/search_goods.dart';
import 'package:fluttershopping/home/view/home_subview.dart';
import 'package:fluttershopping/http/core/hi_net.dart';
import 'package:fluttershopping/utils/loading.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ListElement>? list;
  List<ListElement>? children;
  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("分类"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            const SearchButton(),
            const SizedBox(height: 15),
            Row(children: [
              SizedBox(
                width: 120,
                height: MediaQuery.of(context).size.height - 300,
                child: leftView(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                height: MediaQuery.of(context).size.height - 300,
                child: rightView(),
              )
            ])
          ],
        ));
  }

  Widget leftView() {
    if (list != null && list!.isNotEmpty) {
      return ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, index) {
            ListElement el = list![index];
            return ListTile(
              title: Text(el.name),
              onTap: () => {
                setState(() {
                  children = list?[index].children;
                })
              },
            );
          });
    }
    return const Text("");
  }

  void initData() async {
    Future.delayed(const Duration(seconds: 0), () {
      // 这里是你想要延时执行的代码
      Loading.show(context);
    });
    CategoryRequest request = CategoryRequest();
    request.add("s", "api/category/list");
    // showLoadingDialog(context, "加载中...");
    var res = await HiNet.getInstance().send(request);
    CategoryModel model = CategoryModel.fromJson(jsonDecode(res.toString()));
    // hideLoadingDialog(context);
    if (model.status == 200) {
      setState(() {
        list = model.data.list;
        children = model.data.list[0].children;
        Future.delayed(const Duration(seconds: 0), () {
          // 这里是你想要延时执行的代码
          Loading.dismiss(context);
        });
      });
    } else {}
  }

  Widget rightView() {
    if (children != null && children!.isNotEmpty) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 每行显示4个子控件
          crossAxisSpacing: 10.0, // 子控件之间的水平间距
          mainAxisSpacing: 10.0, // 子控件之间的垂直间距
          childAspectRatio: 0.65, // 子控件的宽高比
        ),
        itemBuilder: (context, index) {
          ListElement element = children![index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {

                  NavigatorUtils.pushPage(context: context, targetPage: SearchGoodsPage(categoryId: element.categoryId.toString(),), dismissCallBack: (v){});

                },
                child: Column(
                  children: [
                    Image.network(
                        width: 50,
                        height: 80,
                        element.image!.previewUrl,
                        fit: BoxFit.contain),
                    Text(element.name)
                  ],
                ),
              ),
              
            ],
          );
        },
        itemCount: children?.length,
      );
    } else {
      return const Center(
        child: Text("暂无内容"),
      );
    }
  }
}
