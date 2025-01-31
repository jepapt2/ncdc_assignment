import 'package:ncdc_assignment/features/content/models/content/content.dart';

class ContentFactory {
  static Content create({
    int? id,
    String? title,
    String? body,
  }) {
    return Content(
      id: id ?? 1,
      title: title ?? 'テストタイトル',
      body: body ?? 'テスト本文',
    );
  }

  static List<Content> createMany({
    int count = 2,
    String? titlePrefix,
    String? bodyPrefix,
  }) {
    return List.generate(count, (index) {
      return create(
        id: index + 1,
        title: '${titlePrefix ?? 'テストタイトル'}${index + 1}',
        body: '${bodyPrefix ?? 'テスト本文'}${index + 1}',
      );
    });
  }

  static CreateContentDTO createDTO({
    String? title,
    String? body,
  }) {
    return CreateContentDTO(
      title: title ?? 'テストタイトル',
      body: body ?? 'テスト本文',
    );
  }

  static List<Map<String, dynamic>> createJsonList({
    int count = 2,
  }) {
    return createMany(count: count).map((content) => content.toJson()).toList();
  }
}
