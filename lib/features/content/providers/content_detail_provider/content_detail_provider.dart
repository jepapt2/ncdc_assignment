import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_detail_provider.g.dart';

@riverpod
class ContentDetail extends _$ContentDetail {
  UseContentApi get _contentApi => UseContentApi(ref);

  IsSaveLoading get _isSaveLoadingNotifier =>
      ref.read(isSaveLoadingProvider.notifier);

  IsEditingContentDetail get _isEditingNotifier =>
      ref.read(isEditingContentDetailProvider.notifier);

  ContentList get _contentListProviderNotifier =>
      ref.read(contentListProvider.notifier);

  @override
  Future<Content> build(int id) async {
    await fetchContent(id);
    return state.requireValue;
  }

  Future<void> fetchContent(int id) async {
    state = const AsyncValue.loading();
    AsyncValue.guard(() async {
      final content = await _contentApi.get(id);
      state = AsyncValue.data(content);
    });
  }

  Future<Content?> updateContent(CreateContentDTO content) async {
    try {
      _isSaveLoadingNotifier.startLoading();
      final now = DateTime.now();
      final result = await _contentApi.update(Content(
        id: id,
        body: content.body ?? state.value?.body ?? '',
        title: content.title ?? state.value?.title ?? '',
        createdAt: state.value?.createdAt,
        updatedAt: now,
      ));
      state = AsyncValue.data(result);
      _contentListProviderNotifier.updateState(result);
      _isEditingNotifier.endEditing();
      return result;
    } catch (e) {
      print(e);
      showToast('更新に失敗しました');
      return null;
    } finally {
      _isSaveLoadingNotifier.endLoading();
    }
  }
}
