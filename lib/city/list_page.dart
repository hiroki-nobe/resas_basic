import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resas_basic/city/detail_page.dart';
import 'package:resas_basic/env.dart';

class CityListPage extends StatefulWidget {
  const CityListPage({super.key});

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _citiesfuture;

  @override
  void initState() {
    super.initState();
    _citiesfuture = Future.delayed(const Duration(seconds: 3));
    const host = 'opendata.resas-portal.go.jp';
    const endpoint = '/api/v1/cities';
    final headers = {
      'X-API-KEY': Env.resasApiKey,
    };

    _citiesfuture = http
        .get(
          Uri.https(host, endpoint),
          headers: headers,
        )
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder(
        future: _citiesfuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final List json = jsonDecode(snapshot.data!)['result'] as List;
              final items = json.cast<Map<String, dynamic>>();
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    title: Text(item['cityVame'] as String),
                    subtitle: const Text('政令指定都市'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) =>
                              CityDetailPage(city: item['cityVame'] as String),
                        ),
                      );
                    },
                  );
                },
              );
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }
          // 非同期処理が完了するまではインジケータを表示します。
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
