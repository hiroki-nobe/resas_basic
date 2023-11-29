import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村の詳細'),
      ),
      body: const Center(
        child: Text('市区町村の詳細画面です'),
      ),
    );
  }
}
