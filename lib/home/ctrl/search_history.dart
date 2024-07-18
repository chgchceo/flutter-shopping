
import 'package:flutter/material.dart';

import 'package:fluttershopping/home/ctrl/search_goods.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  // 定义一个变量来保存 TextField 的输入值
  String _myText = '';

  // 当 TextField 的内容改变时，更新这个变量
  void _handleTextChange(String value) {
    setState(() {
      _myText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("商品搜索"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 25),
              topSearch(),
              const SizedBox(height: 25),
              midView(),
              const SizedBox(height: 25),
              SizedBox(
                height: 560,
                child: bottomView(),
              )
            ],
          ),
        ));
  }

  Widget bottomView() {
    return GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Container(
              width: 110,
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(17.5))),
              child: const Center(child: Text("data")),
            ),
          );
        });
  }

  Widget midView() {
    return Row(
      children: [
        const SizedBox(width: 20),
        const Text(
          "最近搜索",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        GestureDetector(
          child: const Icon(Icons.clear),
          onTap: () {
            print("clear");
          },
        ),
        const SizedBox(width: 20),
      ],
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
                  decoration: const InputDecoration(
                    // labelText: '输入文本',
                    hintText: '请输入搜索关键字',
                    border: InputBorder.none,

                    // 你可以添加更多装饰，比如前缀或后缀图标
                  ),
                  // 当文本改变时调用
                  onChanged: _handleTextChange,
                ),
              ),
              Container(
                color: Colors.red,
                width: 100,
                child: TextButton(
                    onPressed: () => {
                          NavigatorUtils.pushPage(
                              context: context,
                              targetPage:  SearchGoodsPage( keyword: _myText,),
                              dismissCallBack: (e){})
                        },
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
