import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttershopping/home/ctrl/search_history.dart';
import 'package:fluttershopping/home/model/home_model.dart';
import 'package:fluttershopping/utils/navigator_utils.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 30;
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
                // 使用SizedBox来设置按钮的宽高
                width: w, // 自定义宽度
                height: 50, // 自定义高度
                child: const NewWidget()),
            const SizedBox(
              width: 15,
            ),
          ],
        )
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        // 设置边框颜色等样式
        side: WidgetStateProperty.all(
          const BorderSide(color: Colors.grey, width: 1.0),
        ),
        // 如果需要设置按钮的内边距，可以在这里设置
        // padding: MaterialStateProperty.all(
        //     EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
      ),
      onPressed: () {
        // 按钮点击时执行的操作

        NavigatorUtils.pushPage(
            context: context,
            targetPage: const SearchHistoryPage(),
            dismissCallBack: (e) => {});
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start, // 使内容居中
        children: [
          Icon(Icons.search, size: 24, color: Colors.grey), // 搜索图标
          SizedBox(width: 10), // 图标和文字之间的间隔
          Text('请在此输入搜索关键字',
              style: TextStyle(fontSize: 16, color: Colors.grey)), // 搜索文字
        ],
      ),
    );
  }
}

Widget naviGridView(BuildContext context, List<Datum>? data) {
  // 检查 data 是否为空，如果为空，则不渲染 GridView
  if (data == null || data.isEmpty) {
    return Container(
      alignment: Alignment.center,
      child: const Text('No data available'),
    );
  }

  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),

    // 定义网格的列数和其他属性
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5, // 每行显示4个子控件
      crossAxisSpacing: 10.0, // 子控件之间的水平间距
      mainAxisSpacing: 10.0, // 子控件之间的垂直间距
      childAspectRatio: 0.85, // 子控件的宽高比
    ),
    // 构建每个网格项
    itemBuilder: (BuildContext context, int index) {
      Datum mo = data[index];
      final String? imageUrl = mo.imgUrl;
      final String? name = mo.text;
      if (imageUrl == null) {
        // 如果 imageUrl 为 null，返回一个占位符或错误提示
        return const Text('No image available');
      }

      return Column(
        children: [
          const SizedBox(height: 10),
          Image.network(
            height: 40,
            width: 40,
            imageUrl, // 使用从 data 列表中获取的图片URL
            fit: BoxFit.cover, // 图片填充方式
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              // 处理图片加载失败的情况
              return const Icon(Icons.error_outline);
            },
          ),
          const SizedBox(height: 10),
          Text(name!)
        ],
      );
    },
    // 网格项的总数
    itemCount: data.length, // 使用 data 列表的长度
  );
}

class BannerCarousel extends StatefulWidget {
  final List<Datum>? bannerData;
  const BannerCarousel({super.key, this.bannerData});

  @override
  // ignore: library_private_types_in_public_api
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;

  Timer? _timer;
  int currentPage = 0;
  int nextPage = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0); // 确保初始化

    // 每3秒自动切换到下一张图片
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? images = widget.bannerData
        ?.map((mo) => Image.network(
              mo.imgUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ))
        .toList();

    return PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) => {
              setState(() {
                currentPage = index;
                nextPage = (currentPage + 1) % images.length;
              })
            },
        children: images!);
  }
}
