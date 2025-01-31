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
        id: index,
        title: '$titlePrefix${index + 1}',
        body: '$bodyPrefix${index + 1}',
      );
    });
  }
}
