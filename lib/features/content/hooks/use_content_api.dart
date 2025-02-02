import 'package:ncdc_assignment/core/hooks/utils/rethrow_api_function.dart';

import '../models/content/content.dart';
import '../../../core/hooks/use_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UseContentApi {
  final UseApi _api;

  UseContentApi(Ref ref) : _api = UseApi(ref, '/content');

  Future<List<Content>> getList() async {
    return rethrowApiFunction(() {
      return _api.getList(
        fromJson: Content.fromJson,
      );
    });
  }

  Future<Content> get(int id) async {
    return rethrowApiFunction(() {
      return _api.get<Content>(
        path: '$id',
        fromJson: Content.fromJson,
      );
    });
  }

  Future<Content> create(CreateContentDTO dto) async {
    return rethrowApiFunction(() {
      return _api.post<Content>(
        fromJson: Content.fromJson,
        data: dto.toJson(),
      );
    });
  }

  Future<Content> update(Content content) async {
    return rethrowApiFunction(() {
      return _api.put<Content>(
        fromJson: Content.fromJson,
        data: content.toJson(),
        path: content.id.toString(),
      );
    });
  }

  Future<void> delete(int id) async {
    return rethrowApiFunction(() {
      return _api.delete(
        path: id.toString(),
      );
    });
  }
}
