import '../models/content/content.dart';
import '../../../core/hooks/use_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UseContentApi {
  final UseApi _api;

  UseContentApi(WidgetRef ref) : _api = UseApi(ref, '/content');

  Future<List<Content>> getList() async {
    return _api.getList<Content>(
      fromJson: Content.fromJson,
    );
  }

  Future<Content> get(int id) async {
    return _api.get<Content>(
      path: '$id',
      fromJson: Content.fromJson,
    );
  }

  Future<Content> create(CreateContentDTO dto) async {
    return _api.post<Content>(
      fromJson: Content.fromJson,
      data: dto.toJson(),
    );
  }

  Future<Content> update(Content content) async {
    return _api.put<Content>(
      fromJson: Content.fromJson,
      data: content.toJson(),
      path: content.id.toString(),
    );
  }

  Future<Content> delete(int id) async {
    return _api.delete<Content>(
      path: '$id',
      fromJson: Content.fromJson,
    );
  }
}
