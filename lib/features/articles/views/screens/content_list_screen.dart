import 'package:flutter/material.dart';
import '../../../../core/theme/color_theme.dart';

class ContentListScreen extends StatelessWidget {
  const ContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'コンテンツ一覧',
          style: TextStyle(color: ColorTheme.textRegular),
        ),
        backgroundColor: ColorTheme.backgroundWhite,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // 仮のデータ数
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                'コンテンツタイトル $index',
                style: const TextStyle(
                  color: ColorTheme.textRegular,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'コンテンツの説明文がここに入ります',
                style: TextStyle(
                  color: ColorTheme.textLight,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                // TODO: 詳細画面への遷移
              },
            ),
          );
        },
      ),
    );
  }
}
