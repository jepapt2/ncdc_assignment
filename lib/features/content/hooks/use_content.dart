import '../models/content/content.dart';
import '../../../core/hooks/use_api.dart';

class ContentApi {
  static final _api = UseApi('/content');

  static Future<List<Content>> getList() async {
    return _api.getList<Content>(
      fromJson: Content.fromJson,
    );
  }

  static Future<Content> get(int id) async {
    return _api.get<Content>(
      path: '$id',
      fromJson: Content.fromJson,
    );
  }

  static Future<Content> create(CreateContentDTO dto) async {
    return _api.post<Content>(
      fromJson: Content.fromJson,
      data: dto.toJson(),
    );
  }

  static Future<Content> update(Content content) async {
    return _api.put<Content>(
      fromJson: Content.fromJson,
      data: content.toJson(),
      path: content.id.toString(),
    );
  }

  static Future<Content> delete(int id) async {
    return _api.delete<Content>(
      path: '$id',
      fromJson: Content.fromJson,
    );
  }
}
