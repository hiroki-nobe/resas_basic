import 'package:flutter/material.dart';
import 'package:resas_basic/city/detail_page.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cities = [
      '札幌市',
      '横浜市',
      '川崎市',
      '名古屋市',
      '京都市',
      '大阪市',
      '堺市',
      '神戸市',
      '岡山市',
      '広島市',
      '北九州市',
      '福岡市',
      '熊本市',
      '那覇市',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<void>(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // 非同期処理が完了（3秒後）したこと示す状態です。
            case ConnectionState.done:
              // 元々のListViewを移動させただけです
              return ListView(
                children: [
                  for (final city in cities)
                    ListTile(
                      title: Text(city),
                      subtitle: const Text('政令指定都市'),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => CityDetailPage(city: city),
                          ),
                        );
                      },
                    ),
                ],
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
