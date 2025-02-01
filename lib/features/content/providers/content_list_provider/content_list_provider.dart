import 'package:flutter/material.dart';
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

  @override
  Future<List<Content>> build() async {
    await fetchContents();
    return state.requireValue;
  }

  Future<void> fetchContents() async {
    state = const AsyncValue.loading();
    try {
      final contents = await _contentApi.getList();
      state = AsyncValue.data(contents);
    } catch (e) {
      print(e);
      state = AsyncValue.error(e, StackTrace.current);
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
      print(e);
      showToast('削除に失敗しました');
      return false;
    } finally {
      _isSaveLoadingNotifier.endLoading();
    }
  }
}
