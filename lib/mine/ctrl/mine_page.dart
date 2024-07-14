
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State <MinePage> createState() =>  MinePageState();
}

class  MinePageState extends State <MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("我的"),),
      body: const Text('我的'),
    );
  }
}