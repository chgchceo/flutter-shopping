import 'package:flutter/material.dart';

class ChatItemPage extends StatefulWidget {
  const ChatItemPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatItemPageState createState() => _ChatItemPageState();
}

// with AutomaticKeepAliveClientMixin
class _ChatItemPageState extends State<ChatItemPage> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  List<String> cityNames = [
    '北京',
    '上海',
    '广州',
  ];

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData();
        isLoading = true;
        print("object");
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = '高级功能列表下拉刷新与上拉加载更多功能实现';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,

        child: ListView.builder(
          controller: _scrollController,
          itemCount: cityNames.length + (isLoading ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index == cityNames.length) {
              // 显示加载中的占位符
              return isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container();
            }

            if (index == 0) {
              return Column(
                children: [
                  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "header",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      )),
                  _item(cityNames[index])
                ],
              );
            } else if (index == cityNames.length - 1) {
              return Column(
                children: [
                  _item(cityNames[index]),
                  Container(
                    height: 300,
                    color: Colors.green,
                  ),
                ],
              );
            } else {
              return _item(cityNames[index]);
            }
          },
        ),
        // child: ListView(
        //
        //   controller: _scrollController,
        //   children: _buildList(),
        // ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      cityNames = cityNames.reversed.toList();
      isLoading = true;
    });
    return;
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  _loadData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }

  Future<void> loadMoreData() async {
    setState(() {
      isLoading = true;
    });
    // 模拟网络请求延迟
    await Future.delayed(const Duration(seconds: 2));

    // 假设你从网络或其他地方获取了新数据
    // List<String> newItems = await fetchMoreData();

    setState(() {
      // items.addAll(newItems);
      isLoading = false;
    });
  }
}
