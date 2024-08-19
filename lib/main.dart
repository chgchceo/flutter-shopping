import 'package:flutter/material.dart';
import 'package:fluttershopping/cart/ctrl/cart_page.dart';
import 'package:fluttershopping/category/ctrl/category_page.dart';
import 'package:fluttershopping/home/ctrl/home_page.dart';
import 'package:fluttershopping/mine/ctrl/mine_page.dart';
import 'package:fluttershopping/utils/sp_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const MinePage()
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    await SPUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_currentIndex],
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: pageList,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 17,
        selectedFontSize: 17,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
      ),
    );
  }
}
