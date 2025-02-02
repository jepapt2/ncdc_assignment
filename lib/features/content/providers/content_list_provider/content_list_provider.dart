import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_list_provider.g.dart';

@riverpod
class ContentList extends _$ContentList {
  UseContentApi get _contentApi => UseContentApi(ref);

  IsSaveLoading get _isSaveLoadingNotifier =>
      ref.read(isSaveLoadingProvider.notifier);

  final logger = Logger();
  @override
  Future<List<Content>> build() async {
    await fetchContents();
    return state.valueOrNull ?? [];
  }

  Future<void> fetchContents() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _contentApi.getList();
    }, (err) {
      logger.e(err);
      return false;
    });
  }

  Future<Content?> create(CreateContentDTO dto) async {
    try {
      _isSaveLoadingNotifier.startLoading();
      final result = await _contentApi.create(dto);
      state = AsyncValue.data([...state.requireValue, result]);
      return result;
    } catch (e) {
      logger.e(e);
      showToast('作成に失敗しました');
      return null;
    } finally {
      _isSaveLoadingNotifier.endLoading();
    }
  }

  Future<bool> delete(Content content) async {
    try {
      _isSaveLoadingNotifier.startLoading();
      await _contentApi.delete(content.id).then((_) {
        state = AsyncValue.data(
          state.value?.where((element) => element.id != content.id).toList() ??
              [],
        );
      });
      return true;
    } catch (e) {
      logger.e(e);
      showToast('削除に失敗しました');
      return false;
    } finally {
      _isSaveLoadingNotifier.endLoading();
    }
  }

  void updateState(Content content) {
    state = AsyncValue.data(
      state.value?.map((e) => e.id == content.id ? content : e).toList() ?? [],
    );
  }
}
