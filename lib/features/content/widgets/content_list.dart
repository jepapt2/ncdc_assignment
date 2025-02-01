import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/theme/color_theme.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import 'content_list_tile.dart';
import 'content_list_tile_skeleton.dart';

class ContentList extends HookConsumerWidget {
  const ContentList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentListState = ref.watch(contentListProvider);
    final contentListNotifier = ref.read(contentListProvider.notifier);

    return RefreshIndicator(
      color: ColorTheme.brand,
      backgroundColor: ColorTheme.backgroundLight,
      onRefresh: () async {
        await contentListNotifier.fetchContents();
      },
      child: contentListState.when(
        data: (contents) {
          if (contents.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.note_alt_outlined,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'コンテンツがありません',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      contentListNotifier.fetchContents();
                    },
                    child: const Text('再読み込み'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              final content = contents[index];
              return ContentListTile(
                content: content,
                onTap: () {
                  print('tap');
                },
              );
            },
          );
        },
        loading: () => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const ContentListTileSkeleton();
          },
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'リストの読み込みに失敗しました',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  ref.read(contentListProvider.notifier).fetchContents();
                },
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
