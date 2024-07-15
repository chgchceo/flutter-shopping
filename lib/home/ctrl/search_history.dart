import 'package:flutter/material.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State<SearchHistoryPage> createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("搜索历史"),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      ),

      body: const Text("data"),
    );
  }
}
